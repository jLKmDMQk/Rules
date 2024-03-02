#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "Clash/BaiDuTieBa/BaiDuTieBa.list"
    "Clash/Baidu/Baidu.list"
)

geosite_filenames=(
    "baidu@all"
)

sites_common_handle "./surge/baidu-domain.list" "./surge/baidu-ruleset.list" "./list/baidu-site.list"
