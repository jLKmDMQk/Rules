#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
)

geosite_filenames=(
    "bilibili"
)

sites_common_handle "./surge/bilibili-domain.list" "./surge/bilibili-ruleset.list" "./list/bilibili-site.list"
