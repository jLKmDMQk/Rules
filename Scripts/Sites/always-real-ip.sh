#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/NTPService/NTPService.list"
)

domain_list_urls=(
    "https://raw.githubusercontent.com/jLKmDMQk/Rules/refs/heads/master/Rules/always-real-ip.list"
)

geosite_filenames=(
    "category-ntp"
    "connectivity-check"
)

sites_common_handle "" "" "" "./result/sing-box/always-real-ip.json"
