#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/BaiDuTieBa/BaiDuTieBa.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Baidu/Baidu.list"
)

geosite_filenames=(
    "baidu"
)

sites_common_handle "./surge/baidu-domain.list" "./surge/baidu-ruleset.list" "./list/baidu-site.list"
