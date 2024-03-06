#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

rule_set_urls=(
    "rule/Surge/Cryptocurrency/Cryptocurrency.list"

    "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/Porn.list"
    "https://raw.githubusercontent.com/LM-Firefly/Rules/master/PROXY/Porn.list"
)

domain_list_urls=(
    "https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/gfw.txt"
)

geosite_filenames=(
    "category-browser-!cn@!cn"
    "category-cas@!cn"
    "category-cryptocurrency@!cn"
    "category-entertainment@!cn"
    "category-media@!cn"
    "category-porn@!cn"
    "category-scholar-!cn@!cn"
    "category-social-media-!cn@!cn"

    "gitbook@!cn"
    "github@!cn"
    "gitlab@!cn"
    "docker@!cn"
)
