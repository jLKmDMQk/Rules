#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh
source ./Scripts/Overseas/config.sh

sites_common_handle "./surge/overseas-site-domain.list" "./surge/overseas-site-ruleset.list" "./list/overseas-site.list"
