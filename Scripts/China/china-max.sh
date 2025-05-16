#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

domain_list_urls=(
    "rule/Surge/ChinaMax/ChinaMax_Domain.list"
)

geosite_filenames=(
    "geolocation-cn"
)

sites_common_handle "./result/surge/china-max-site-domain.list" "./result/surge/china-max-site-ruleset.list" "./result/list/china-max-site.list" "./result/sing-box/china-max-site.json" "./result/clash/china-max-site.yaml"
