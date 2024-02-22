import os
import requests
import re
import json


def read_config_file(file_path):
    with open(file_path, "r") as file:
        content = file.read()
    return content


def extract_rule_set_urls(content):
    pattern = r"rule_set_urls=\(\n([\s\S]*?)\n\)"
    match = re.search(pattern, content)
    if match:
        urls_str = match.group(1)
        urls = [url.strip().strip('"') for url in urls_str.split("\n") if url.strip()]
        return urls
    return []


def fetch_rule_urls(rule_set_urls):
    rule_urls = []
    headers = {"Authorization": f'token {os.environ.get("GITHUB_API_TOKEN")}'}
    response = requests.get(
        "https://api.github.com/repos/blackmatrix7/ios_rule_script/contents/rule/Clash?ref=master",
        headers=headers,
    )
    if response.status_code == 200:
        try:
            data = response.json()
            if isinstance(data, list):
                # 添加需要忽略的路径
                ignore_paths = [
                    "rule/Clash/AMD/",
                    "rule/Clash/Acer/",
                    "rule/Clash/AdGuardSDNSFilter/",
                    "rule/Clash/Adidas/",
                    "rule/Clash/Adobe/",
                    "rule/Clash/AdobeActivation/",
                    "rule/Clash/Advertising/",
                    "rule/Clash/AdvertisingLite/",
                    "rule/Clash/AdvertisingMiTV/",
                    "rule/Clash/AdvertisingTest/",
                    "rule/Clash/Amazon/",
                    "rule/Clash/AmazonIP/",
                    "rule/Clash/Arphic/",
                    "rule/Clash/AsianMedia/",
                    "rule/Clash/Assassin'sCreed/",
                    "rule/Clash/Atomdata/",
                    "rule/Clash/BMW/",
                    "rule/Clash/Battle/",
                    "rule/Clash/Beats/",
                    "rule/Clash/BiliBiliIntl/",
                    "rule/Clash/Bing/",
                    "rule/Clash/Blizzard/",
                    "rule/Clash/BlockHttpDNS/",
                    "rule/Clash/Blued/",
                    "rule/Clash/Canon/",
                    "rule/Clash/China/",
                    "rule/Clash/ChinaIPs/",
                    "rule/Clash/ChinaIPsBGP/",
                    "rule/Clash/ChinaMax/",
                    "rule/Clash/ChinaMaxNoIP/",
                    "rule/Clash/ChinaMaxNoMedia/",
                    "rule/Clash/ChinaNoMedia/",
                    "rule/Clash/ChinaTest/",
                    "rule/Clash/Classic/",
                    "rule/Clash/ClubhouseIP/",
                    "rule/Clash/DNS/",
                    "rule/Clash/Dell/",
                    "rule/Clash/Developer/",
                    "rule/Clash/DiabloIII/",
                    "rule/Clash/DigiCert/",
                    "rule/Clash/Direct/",
                    "rule/Clash/Download/",
                    "rule/Clash/EasyPrivacy/",
                    "rule/Clash/Epic/",
                    "rule/Clash/FlipBoard/",
                    "rule/Clash/Game/",
                    "rule/Clash/Gigabyte/",
                    "rule/Clash/GitLab/",
                    "rule/Clash/Global/",
                    "rule/Clash/GlobalMedia/",
                    "rule/Clash/GlobalScholar/",
                    "rule/Clash/GlobalSign/",
                    "rule/Clash/Gucci/",
                    "rule/Clash/HP/",
                    "rule/Clash/HWTV/",
                    "rule/Clash/Hearthstone/",
                    "rule/Clash/HeroesoftheStorm/",
                    "rule/Clash/Hijacking/",
                    "rule/Clash/IBM/",
                    "rule/Clash/IKEA/",
                    "rule/Clash/IPTVMainland/",
                    "rule/Clash/IPTVOther/",
                    "rule/Clash/Intel/",
                    "rule/Clash/Intercom/",
                    "rule/Clash/Japonx/",
                    "rule/Clash/Jetbrains/",
                    "rule/Clash/KKTV/",
                    "rule/Clash/Kantv/",
                    "rule/Clash/LG/",
                    "rule/Clash/Lan/",
                    "rule/Clash/LinkedIn/",
                    "rule/Clash/Logitech/",
                    "rule/Clash/Maocloud/",
                    "rule/Clash/McDonalds/",
                    "rule/Clash/Microsoft/",
                    "rule/Clash/MicrosoftEdge/",
                    "rule/Clash/NTPService/",
                    "rule/Clash/Nike/",
                    "rule/Clash/Nintendo/",
                    "rule/Clash/Nvidia/",
                    "rule/Clash/OneDrive/",
                    "rule/Clash/Overwatch/",
                    "rule/Clash/PayPal/",
                    "rule/Clash/PotatoChat/",
                    "rule/Clash/Privacy/",
                    "rule/Clash/PrivateTracker/",
                    "rule/Clash/Proxy/",
                    "rule/Clash/ProxyLite/",
                    "rule/Clash/QuickConnect/",
                    "rule/Clash/README.md/",
                    "rule/Clash/RemoteDesktop/",
                    "rule/Clash/STUN/",
                    "rule/Clash/Samsung/",
                    "rule/Clash/Scholar/",
                    "rule/Clash/Shopee/",
                    "rule/Clash/Sony/",
                    "rule/Clash/Speedtest/",
                    "rule/Clash/StarCraftII/",
                    "rule/Clash/Starbucks/",
                    "rule/Clash/Steam/",
                    "rule/Clash/SteamCN/",
                    "rule/Clash/Synology/",
                    "rule/Clash/TeamViewer/",
                    "rule/Clash/Teams/",
                    "rule/Clash/TelegramNL/",
                    "rule/Clash/TelegramSG/",
                    "rule/Clash/TelegramUS/",
                    "rule/Clash/Tesla/",
                    "rule/Clash/TikTok/",
                    "rule/Clash/U17/",
                    "rule/Clash/Ubuntu/",
                    "rule/Clash/Unity/",
                    "rule/Clash/VISA/",
                    "rule/Clash/VidolTV/",
                    "rule/Clash/WeTV/",
                    "rule/Clash/WeType/",
                    "rule/Clash/WorldofWarcraft/",
                    "rule/Clash/Xbox/",
                    "rule/Clash/ZhihuAds/",
                    "rule/Clash/iQIYIIntl/",
                ]
                for item in data:
                    if "path" in item:
                        path = item["path"] + "/"
                        if (
                            not any(url for url in rule_set_urls if path in url)
                            and path not in ignore_paths
                        ):
                            rule_urls.append(item["html_url"])
        except json.JSONDecodeError:
            pass
    else:
        print(f"获取规则列表失败，状态码：{response.status_code}")
    return rule_urls


if __name__ == "__main__":
    config_paths = [
        "./China/config.sh",
        "./Overseas/config.sh",
        "./Sites/360.sh",
        "./Sites/alibaba.sh",
        "./Sites/apple.sh",
        "./Sites/baidu.sh",
        "./Sites/bytedance.sh",
        "./Sites/tencent.sh",
    ]

    rule_set_urls = []
    for config_path in config_paths:
        content = read_config_file(config_path)
        config_path_rule_set_urls = extract_rule_set_urls(content)
        rule_set_urls += config_path_rule_set_urls

    rule_urls = fetch_rule_urls(rule_set_urls)

    for url in rule_urls:
        print(url)
