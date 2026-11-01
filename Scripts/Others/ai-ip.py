#!/usr/bin/env python3

import ipaddress
import json
import re
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from urllib.parse import urlencode
from urllib.request import Request, urlopen


def fetch_text(url):
    request = Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urlopen(request, timeout=30) as response:
        return response.read().decode("utf-8")


def resolve_aws_endpoint(hostname):
    networks = set()
    # 使用 DoH，避免系统 DNS 的 fake-ip 和本机 IPv6 配置影响结果。
    for record_type, version in ((1, 4), (28, 6)):
        query = urlencode({"name": hostname, "type": record_type})
        data = json.loads(fetch_text(f"https://dns.google/resolve?{query}"))
        if data["Status"] == 3:  # NXDOMAIN：该区域尚未提供公开端点。
            continue
        if data["Status"] != 0 or data.get("TC", False):
            raise ValueError(f"DNS 查询失败：{hostname}，类型 {record_type}，响应 {data}")
        for answer in data.get("Answer", []):
            if answer["type"] != record_type:
                continue
            address = ipaddress.ip_address(answer["data"])
            if address.version != version or not address.is_global:
                raise ValueError(f"DNS 返回了无效的公网地址：{hostname}，{address}")
            networks.add(ipaddress.ip_network(str(address)))
    return networks


def anthropic_networks():
    page = fetch_text("https://platform.claude.com/docs/en/api/ip-addresses.md")
    networks = set()
    # 只读取入站、出站下的 IPv4/IPv6 小节，不纳入已停用地址。
    for heading in ("Inbound IP addresses", "Outbound IP addresses"):
        section = re.search(
            rf"^## {re.escape(heading)}\s*\n(.*?)(?=^## |\Z)", page, re.M | re.S
        )
        if section is None:
            raise ValueError(f"Anthropic 文档缺少 {heading} 小节")
        section_networks = set()
        for version, content in re.findall(
            r"^### IPv([46])\s*\n(.*?)(?=^#{1,3} |\Z)",
            section.group(1),
            re.M | re.S,
        ):
            for cidr in re.findall(r"[0-9a-fA-F:.]+/\d+", content):
                network = ipaddress.ip_network(cidr)
                if network.version != int(version) or not network.is_global:
                    raise ValueError(f"Anthropic 文档包含无效的公网 CIDR：{cidr}")
                section_networks.add(network)
        if not section_networks:
            raise ValueError(f"Anthropic 文档的 {heading} 小节没有有效 CIDR")
        networks.update(section_networks)

    # AWS 发布的 IP 数据提供当前区域，SDK 分区元数据界定商用区域。
    aws_ranges = json.loads(fetch_text("https://ip-ranges.amazonaws.com/ip-ranges.json"))
    partitions = json.loads(
        fetch_text("https://raw.githubusercontent.com/boto/botocore/develop/botocore/data/partitions.json")
    )
    partition = next(item for item in partitions["partitions"] if item["id"] == "aws")
    regions = sorted(
        {
            item["region"]
            for field in ("prefixes", "ipv6_prefixes")
            for item in aws_ranges[field]
            if re.fullmatch(partition["regionRegex"], item["region"])
        }
    )
    hostname = re.search(r"`([^`\s]*\{region\}[^`\s]*)`", page)
    if not regions or hostname is None:
        raise ValueError("未找到 Anthropic AWS 区域或端点模板")
    endpoints = [hostname.group(1).replace("{region}", region) for region in regions]
    with ThreadPoolExecutor(max_workers=8) as executor:
        endpoint_networks = list(executor.map(resolve_aws_endpoint, endpoints))
    resolved_count = sum(bool(items) for items in endpoint_networks)
    if not resolved_count:
        raise ValueError("所有 Anthropic AWS 端点均未解析到公网 IP")
    for items in endpoint_networks:
        networks.update(items)
    print(f"Anthropic AWS：{resolved_count}/{len(endpoints)} 个区域端点解析到公网 IP")
    return networks


def openai_networks():
    page = fetch_text("https://developers.openai.com/api/docs/guides/ip-addresses.md")
    urls = sorted(set(re.findall(r"https://openai\.com/[^\s)]+\.json", page)))
    if not urls:
        raise ValueError("OpenAI 文档没有提供 IP JSON 来源")
    networks = set()
    for url in urls:
        data = json.loads(fetch_text(url))
        if not data["prefixes"]:
            raise ValueError(f"OpenAI IP 来源为空：{url}")
        for prefix in data["prefixes"]:
            if not any(field in prefix for field in ("ipv4Prefix", "ipv6Prefix")):
                raise ValueError(f"OpenAI IP 来源包含未知前缀：{url}，{prefix}")
            for field, version in (("ipv4Prefix", 4), ("ipv6Prefix", 6)):
                if field in prefix:
                    network = ipaddress.ip_network(prefix[field])
                    if network.version != version or not network.is_global:
                        raise ValueError(f"OpenAI IP 来源包含无效的公网 CIDR：{url}，{prefix[field]}")
                    networks.add(network)
        print(f"OpenAI IP 来源：{url}，{len(data['prefixes'])} 条前缀")
    return networks


def write_rules(name, networks, asn=None):
    networks = sorted(networks, key=lambda item: (item.version, int(item.network_address), item.prefixlen))
    cidrs = [str(network) for network in networks]
    rules = [
        f"{'IP-CIDR' if network.version == 4 else 'IP-CIDR6'},{network}"
        for network in networks
    ]
    if asn is not None:
        rules.append(f"IP-ASN,{asn}")

    address_list = f"{name}-list"
    routeros = []
    for version, menu in ((4, "/ip"), (6, "/ipv6")):
        routeros.extend(
            (
                f"{menu} firewall address-list remove [{menu} firewall address-list find list={address_list}]",
                f"{menu} firewall address-list",
            )
        )
        routeros.extend(
            f'add address="{network}" disabled=no list={address_list}'
            for network in networks
            if network.version == version
        )

    outputs = {
        f"list/{name}.list": "\n".join(cidrs) + "\n",
        f"surge/{name}-ruleset.list": "\n".join(rules) + "\n",
        f"clash/{name}.yaml": "# rule-provider 使用 behavior: classical\npayload:\n"
        + "".join(f'  - "{rule}"\n' for rule in rules),
        f"sing-box/{name}.json": json.dumps(
            {"version": 1, "rules": [{"ip_cidr": cidrs}]}, indent=2
        ) + "\n",
        f"routeros/{address_list}.rsc": "\n".join(routeros) + "\n",
    }
    for filename, content in outputs.items():
        path = Path("result") / filename
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
    print(f"{name}：生成 {len(cidrs)} 条 CIDR，{len(outputs)} 种格式")


if __name__ == "__main__":
    # 两个来源均抓取、校验成功后再写入，失败时保留已有输出。
    anthropic_ips = anthropic_networks()
    openai_ips = openai_networks()
    write_rules("anthropic-ip", anthropic_ips, asn=399358)
    write_rules("openai-ip", openai_ips)
