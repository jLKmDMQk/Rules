#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/Apple/Apple_All.list"
)

geosite_filenames=(
    "apple"
)

sites_common_handle "./result/surge/apple-domain.list" "./result/surge/apple-ruleset.list" "./result/list/apple.list"
