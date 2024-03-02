#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "Clash/Tencent/Tencent.list"
    "Clash/TencentVideo/TencentVideo.list"
    "Clash/WeChat/WeChat.list"
)

geosite_filenames=(
    "tencent@all"
)

sites_common_handle "./surge/tencent-domain.list" "./surge/tencent-ruleset.list" "./list/tencent-site.list"
