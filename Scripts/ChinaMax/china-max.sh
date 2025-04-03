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

sites_common_handle "./surge/china-max-site-domain.list" "./surge/china-max-site-ruleset.list" "./list/china-max-site.list" "./sing-box/china-max-site.json"
