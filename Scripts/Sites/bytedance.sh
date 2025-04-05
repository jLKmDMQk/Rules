#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/ByteDance/ByteDance.list"
)

geosite_filenames=(
    "bytedance"
)

sites_common_handle "./result/surge/bytedance-domain.list" "./result/surge/bytedance-ruleset.list" "./result/list/bytedance-site.list"
