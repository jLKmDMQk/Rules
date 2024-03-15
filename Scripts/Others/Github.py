# !/usr/bin/env python3

import ipaddress
import json
import requests


if __name__ == "__main__":
    github_api_r = requests.get("https://api.github.com/meta")

    ips = []
    data = json.loads(github_api_r.content)
    for item in data:
        try:
            for ip in data.get(item):
                try:
                    ipaddress.ip_network(ip)
                    if type(ipaddress.ip_network(ip)) == ipaddress.IPv4Network:
                        ips.append(ip)
                except ValueError:
                    pass
        except TypeError:
            pass

    sorted_ips = sorted(set(ips), key=ipaddress.ip_network)
    sorted_ips = [str(ip) for ip in sorted_ips]
    result_ips = sorted_ips

    open("./routeros/github-ip-list.rsc", "w").write(
        "/ip firewall address-list remove [/ip firewall address-list find list=github-ip-list]\n"
        + "/ip firewall address-list\n"
    )
    for ip in result_ips:
        open("./routeros/github-ip-list.rsc", "a").write(
            f'add address="{ip}" disabled=no list=github-ip-list\n'
        )
