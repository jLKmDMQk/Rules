#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/Alibaba/Alibaba_All.list"
)

geosite_filenames=(
    "alibaba"
)

sites_common_handle "./result/surge/alibaba-domain.list" "./result/surge/alibaba-ruleset.list" "./result/list/ali-site.list"
