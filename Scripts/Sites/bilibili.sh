#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
)

geosite_filenames=(
    "bilibili"
)

sites_common_handle "./result/surge/bilibili-domain.list" "./result/surge/bilibili-ruleset.list" "./result/list/bilibili-site.list"
