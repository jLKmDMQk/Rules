#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

rule_set_urls=(
    "rule/Surge/Cryptocurrency/Cryptocurrency.list"
    "rule/Surge/Global/Global_All.list"

    "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/Porn.list"
    "https://raw.githubusercontent.com/LM-Firefly/Rules/master/PROXY/Porn.list"
)

domain_list_urls=(
    "https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/gfw.txt"

    "rule/Surge/Global/Global_Domain.list"
)

geosite_filenames=(
    "category-cryptocurrency@!cn"
    "category-porn@!cn"
)
