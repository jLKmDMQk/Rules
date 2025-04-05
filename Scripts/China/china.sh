#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh
source ./Scripts/China/config.sh

sites_common_handle "./result/surge/china-site-domain.list" "./result/surge/china-site-ruleset.list" "./result/list/china-site.list" "./result/sing-box/china-site.json"
