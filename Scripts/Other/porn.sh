#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

geosite_filenames=(
    "category-porn"
)

rule_set_urls=(
    "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/Porn.list"
    "https://raw.githubusercontent.com/LM-Firefly/Rules/master/PROXY/Porn.list"

    "Clash/Japonx/Japonx.list"
)

sites_common_handle "./surge/porn-site-domain.list" "./surge/porn-site-ruleset.list" "./list/porn-site.list"
