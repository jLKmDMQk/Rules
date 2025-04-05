#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/Cryptocurrency/Cryptocurrency.list"
)

geosite_filenames=(
    "category-cryptocurrency"
)

sites_common_handle "./result/surge/cryptocurrency-domain.list" "./result/surge/cryptocurrency-ruleset.list" "./result/list/cryptocurrency-site.list"
