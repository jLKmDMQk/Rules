#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/AliPay/AliPay.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/Alibaba/Alibaba.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/CaiNiao/CaiNiao.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/DingTalk/DingTalk.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/FeiZhu/FeiZhu.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/GaoDe/GaoDe.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/HeMa/HeMa.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/UC/UC.list"
    "https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Clash/XianYu/XianYu.list"
)

geosite_filenames=(
    "alibaba"
)

sites_common_handle "./surge/alibaba-domain.list" "./surge/alibaba-ruleset.list" "./list/ali-site.list"
