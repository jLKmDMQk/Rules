#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

geosite_filenames=(
    "category-cryptocurrency"
)

sites_common_handle "./surge/cryptocurrency-domain.list" "./surge/cryptocurrency-ruleset.list" "./list/cryptocurrency-site.list"
