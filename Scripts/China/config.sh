#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

rule_set_urls=(
    "https://raw.githubusercontent.com/jLKmDMQk/Rules/master/Rules/china-sites.list"

    "rule/Surge/ChinaMaxNoIP/ChinaMaxNoIP_All.list"
)

domain_list_urls=(
    "rule/Surge/ChinaMaxNoIP/ChinaMaxNoIP_Domain.list"
)

geosite_filenames=(
    "geolocation-cn"
)
