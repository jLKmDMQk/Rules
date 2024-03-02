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

sites_common_handle "./surge/apple-domain.list" "./surge/apple-ruleset.list" "./list/apple.list"
