#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

geosite_filenames=(
    "qihoo360"
)

sites_common_handle "./surge/qihoo-domain.list" "./surge/qihoo-ruleset.list" "./list/qihoo-site.list"
