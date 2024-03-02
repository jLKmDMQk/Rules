#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh
source ./Scripts/China/config.sh

sites_common_handle "./surge/china-site-domain.list" "./surge/china-site-ruleset.list" "./list/china-site.list"
