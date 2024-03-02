#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "Clash/AliPay/AliPay.list"
    "Clash/Alibaba/Alibaba.list"
    "Clash/CaiNiao/CaiNiao.list"
    "Clash/DingTalk/DingTalk.list"
    "Clash/FeiZhu/FeiZhu.list"
    "Clash/GaoDe/GaoDe.list"
    "Clash/HeMa/HeMa.list"
    "Clash/UC/UC.list"
    "Clash/XianYu/XianYu.list"
)

geosite_filenames=(
    "alibaba@all"
)

sites_common_handle "./surge/alibaba-domain.list" "./surge/alibaba-ruleset.list" "./list/ali-site.list"
