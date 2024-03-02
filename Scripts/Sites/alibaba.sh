#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

geosite_filenames=(
    "alibaba"
)

sites_common_handle "./surge/alibaba-domain.list" "./surge/alibaba-ruleset.list" "./list/ali-site.list"
