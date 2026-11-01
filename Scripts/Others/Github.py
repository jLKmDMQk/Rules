#!/usr/bin/env python3

import ipaddress
import os
import requests


if __name__ == "__main__":
    headers = {"Accept": "application/vnd.github+json"}
    github_token = os.environ.get("GITHUB_TOKEN")
    if github_token:
        headers["Authorization"] = f"Bearer {github_token}"
    github_api_r = requests.get(
        "https://api.github.com/meta", headers=headers, timeout=30
    )
    github_api_r.raise_for_status()

    ips = []
    data = github_api_r.json()
    if not isinstance(data, dict):
        raise ValueError("GitHub /meta 响应不是 JSON 对象")
    fields = ["web", "api", "git", "hooks"]
    for field in fields:
        ranges = data.get(field)
        if not isinstance(ranges, list) or not ranges:
            raise ValueError(f"GitHub /meta 字段 {field} 缺失或不是非空 IP 列表")
        for ip in ranges:
            network = ipaddress.ip_network(ip)
            if network.version == 4:
                ips.append(str(network))

    sorted_ips = sorted(set(ips), key=ipaddress.ip_network)
    sorted_ips = [str(ip) for ip in sorted_ips]
    result_ips = sorted_ips
    if not result_ips:
        raise ValueError("GitHub /meta 没有返回有效的 IPv4 CIDR")

    with open("./result/routeros/github-ip-list.rsc", "w") as file:
        file.write(
            "/ip firewall address-list remove [/ip firewall address-list find list=github-ip-list]\n"
            + "/ip firewall address-list\n"
        )
        for ip in result_ips:
            file.write(f'add address="{ip}" disabled=no list=github-ip-list\n')
    print(f"GitHub IP：生成 {len(result_ips)} 条 IPv4 CIDR")
