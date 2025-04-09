#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh
source ./Scripts/Overseas/config.sh

sites_common_handle "./result/surge/overseas-site-domain.list" "./result/surge/overseas-site-ruleset.list" "./result/list/overseas-site.list" "./result/sing-box/overseas-site.json" "./result/clash/overseas-site.yaml"
