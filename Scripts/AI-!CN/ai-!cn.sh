#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "https://ruleset.skk.moe/List/non_ip/ai.conf"

    "rule/Surge/BardAI/BardAI.list"
    "rule/Surge/Gemini/Gemini.list"

    "rule/Surge/Claude/Claude.list"
    "rule/Surge/Copilot/Copilot.list"
    "rule/Surge/OpenAI/OpenAI.list"
)

domain_list_urls=(
)

geosite_filenames=(
    "category-ai-!cn"

    "jetbrains-ai@!cn"
)

sites_common_handle "./surge/ai-!cn-domain.list" "./surge/ai-!cn-ruleset.list" "./list/ai-!cn.list" "./sing-box/ai-!cn.json"
