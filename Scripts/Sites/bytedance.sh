#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

geosite_filenames=(
    "bytedance"
)

sites_common_handle "./surge/bytedance-domain.list" "./surge/bytedance-ruleset.list" "./list/bytedance-site.list"
