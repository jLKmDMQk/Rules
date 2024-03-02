#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

geosite_filenames=(
    "tencent"
)

sites_common_handle "./surge/tencent-domain.list" "./surge/tencent-ruleset.list" "./list/tencent-site.list"
