#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

geosite_filenames=(
    "baidu"
)

sites_common_handle "./surge/baidu-domain.list" "./surge/baidu-ruleset.list" "./list/baidu-site.list"
