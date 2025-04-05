#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/Speedtest/Speedtest.list"
)

geosite_filenames=(
    "speedtest"
)

sites_common_handle "./result/surge/speedtest-domain.list" "./result/surge/speedtest-ruleset.list" "./result/list/speedtest-site.list"
