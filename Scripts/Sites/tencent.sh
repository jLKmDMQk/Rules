#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/Tencent/Tencent.list"
)

geosite_filenames=(
    "tencent"
)

sites_common_handle "./result/surge/tencent-domain.list" "./result/surge/tencent-ruleset.list" "./result/list/tencent-site.list" "" "./result/clash/tencent-domain.yaml"
