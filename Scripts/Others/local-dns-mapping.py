#!/usr/bin/env python3

import random

from datetime import datetime, timezone, timedelta


def getCurrentTime():
    # 获取当前时间
    current_time_utc = datetime.now(timezone.utc)
    # 转换为 UTC+8
    current_time_utc8 = current_time_utc + timedelta(hours=8)
    # 格式化时间
    formatted_time = current_time_utc8.strftime("%Y-%m-%d %H:%M:%S")
    return formatted_time


if __name__ == "__main__":
    sources = [
        {
            "name": "alibaba",
            "file_path": "./list/ali-site.list",
            "dns": ["quic://dns.alidns.com", "h3://dns.alidns.com"],
        },
        {
            "name": "baidu",
            "file_path": "./list/baidu-site.list",
            "dns": ["180.76.76.76"],
        },
        {
            "name": "bilibili",
            "file_path": "./list/bilibili-site.list",
            "dns": ["https://doh.pub/dns-query"],
        },
        {
            "name": "bytedance",
            "file_path": "./list/bytedance-site.list",
            "dns": ["180.184.1.1", "180.184.2.2"],
        },
        {
            "name": "360",
            "file_path": "./list/qihoo-site.list",
            "dns": ["https://doh.360.cn/dns-query"],
        },
        {
            "name": "tencent",
            "file_path": "./list/tencent-site.list",
            "dns": ["https://doh.pub/dns-query"],
        },
        {
            "name": "Local & Router",
            "file_path": "./Rules/lan.list",
            "dns": ["system"],
        },
    ]

    file_path = "./surge/local-dns-mapping.sgmodule"
    # file_path = "./local-dns-mapping.sgmodule"

    with open(file_path, "w") as file:
        file.write(
            "#!name=Local DNS Mapping\n"
            + "#!desc=Last Updated: "
            + getCurrentTime()
            + "\n\n[Host]\n"
        )

    with open("./Rules/local-dns-mapping.list", "r") as file:
        local_dns_mapping_content = file.read()
        with open(file_path, "a") as file:
            file.write(local_dns_mapping_content)
            file.write("\n\n")

    for source in sources:
        with open(source.get("file_path"), "r") as file:
            content_list = file.readlines()

            with open(file_path, "a") as file:
                file.write(f'# > {source.get("name")}\n')
                for line in content_list:
                    if line.strip():
                        dns_list = source.get("dns")
                        file.write(
                            f"{line.strip()} = server:{random.choice(dns_list)}\n"
                        )
                        file.write(
                            f"*.{line.strip()} = server:{random.choice(dns_list)}\n"
                        )
                file.write("\n")
