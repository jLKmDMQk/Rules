#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "Clash/360/360.list"
)

sites_common_handle "./surge/qihoo-domain.list" "./surge/qihoo-ruleset.list" "./list/qihoo-site.list"
