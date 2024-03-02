#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh
source ./Scripts/China/config.sh

sites_common_handle "./surge/china-site-domain.list" "./surge/china-site-ruleset.list" "./list/china-site.list"
