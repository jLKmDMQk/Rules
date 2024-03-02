#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "Clash/ByteDance/ByteDance.list"
    "Clash/DouYin/DouYin.list"
)

geosite_filenames=(
    "bytedance@all"
)

sites_common_handle "./surge/bytedance-domain.list" "./surge/bytedance-ruleset.list" "./list/bytedance-site.list"
