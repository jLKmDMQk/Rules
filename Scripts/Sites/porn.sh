#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/Porn.list"
    "https://raw.githubusercontent.com/LM-Firefly/Rules/master/PROXY/Porn.list"
)

geosite_filenames=(
    "category-porn"
)

sites_common_handle "./surge/porn-site-domain.list" "./surge/porn-site-ruleset.list" "./list/porn-site.list"
