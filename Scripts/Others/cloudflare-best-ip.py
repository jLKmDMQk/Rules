#!/usr/bin/env python3

import hashlib
import ipaddress
import json
import re
import time
import urllib.parse
import urllib.request
from pathlib import Path


def parse_metric(value):
    match = re.fullmatch(r"\s*(\d+(?:\.\d+)?)\s*[a-zA-Z/%]*\s*", str(value))
    if not match:
        raise ValueError(f"无法解析指标值: {value!r}")
    return float(match.group(1))


def fetch_data():
    timestamp = str(time.time_ns() // 1_000_000)
    key_source = hashlib.md5(b"DdlTxtN0sUOu").hexdigest()
    key = hashlib.md5(
        f"{key_source}70cloudflareapikey{timestamp}".encode()
    ).hexdigest()
    query = urllib.parse.urlencode({"key": key, "time": timestamp})
    request = urllib.request.Request(
        f"https://api.uouin.com/index.php/index/Cloudflare?{query}",
        headers={
            "Referer": "https://api.uouin.com/cloudflare.html",
            "User-Agent": "Mozilla/5.0",
        },
    )

    with urllib.request.urlopen(request, timeout=30) as response:
        result = json.load(response)

    if str(result.get("code")) != "200":
        raise RuntimeError(result.get("msg", "Cloudflare 优选 IP 数据获取失败"))
    return result["data"]


def select_best_ips(data):
    routes = {
        "ctcc": "电信",
        "cucc": "联通",
        "cmcc": "移动",
        "bgp": "多线",
    }
    selected = []

    for route, label in routes.items():
        route_data = data.get(route)
        if not route_data or route_data.get("code") != 200:
            raise RuntimeError(f"{label}线路数据不可用")

        candidates = []
        for item in route_data.get("info", []):
            try:
                ip = ipaddress.ip_address(item["ip"])
                if not isinstance(ip, ipaddress.IPv4Address):
                    continue
                bandwidth = parse_metric(item["bandwidth"])
                ping = parse_metric(item["ping"])
            except (KeyError, TypeError, ValueError):
                continue

            candidates.append((bandwidth, -ping, str(ip)))

        if not candidates:
            raise RuntimeError(f"{label}线路没有可用的 IPv4 数据")

        bandwidth, negative_ping, ip = max(
            candidates, key=lambda candidate: candidate[:2]
        )
        selected.append((label, ip, bandwidth, -negative_ping))

    return selected


if __name__ == "__main__":
    best_ips = select_best_ips(fetch_data())

    Path("./result/list/cf-best-ip.list").write_text(
        "".join(f"{ip}\n" for _, ip, _, _ in best_ips), encoding="utf-8"
    )

    for label, ip, bandwidth, ping in best_ips:
        print(f"{label}: {ip}，带宽 {bandwidth:g}mb，延迟 {ping:g}ms")
