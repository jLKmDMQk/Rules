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

sites_common_handle "./surge/speedtest-domain.list" "./surge/speedtest-ruleset.list" "./list/speedtest-site.list"
