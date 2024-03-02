#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/ByteDance/ByteDance.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/DouYin/DouYin.list"
)

geosite_filenames=(
    "bytedance"
)

sites_common_handle "./surge/bytedance-domain.list" "./surge/bytedance-ruleset.list" "./list/bytedance-site.list"
