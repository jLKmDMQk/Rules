#!/usr/bin/env python3

import ipaddress
import json
import requests


if __name__ == "__main__":
    worldwide_r = requests.get(
        "https://endpoints.office.com/endpoints/worldwide?clientrequestid=b10c5ed1-bad1-445f-b386-b919946339a7"
    )
    china_r = requests.get(
        "https://endpoints.office.com/endpoints/China?clientrequestid=b10c5ed1-bad1-445f-b386-b919946339a7"
    )

    ips = []
    ipv6s = []
    domains = []

    for item in json.loads(worldwide_r.content):
        if item["id"] in [31, 32, 33, 35, 36, 37, 39]:
            for ip in item.get("ips", []):
                if type(ipaddress.ip_network(ip)) == ipaddress.IPv4Network:
                    ips.append(ip)
            for domain in item.get("urls", []):
                domains.append(domain)

    for item in json.loads(china_r.content):
        if item["id"] in [4, 21]:
            for ip in item.get("ips", []):
                if type(ipaddress.ip_network(ip)) == ipaddress.IPv4Network:
                    ips.append(ip)
            for domain in item.get("urls", []):
                domains.append(domain)

    sorted_ips = sorted(set(ips), key=ipaddress.ip_network)
    sorted_ips = [str(ip) for ip in sorted_ips]
    sorted_ipv6s = sorted(set(ipv6s), key=ipaddress.ip_network)
    sorted_ipv6s = [str(ip) for ip in sorted_ipv6s]
    result_ips = sorted_ips + sorted_ipv6s
    open("./routeros/sharepoint-ip-list.rsc", "w").write(
        "/ip firewall address-list remove [/ip firewall address-list find list=sharepoint-ip-list]\n"
        + "/ip firewall address-list\n"
    )
    for ip in result_ips:
        open("./routeros/sharepoint-ip-list.rsc", "a").write(
            f'add address="{ip}" disabled=no list=sharepoint-ip-list\n'
        )

    open("./list/sharepoint-domain.list", "w")
    for domain in domains:
        domain = domain.replace("*.", "")
        open("./list/sharepoint-domain.list", "a").write(f"{domain}\n")
