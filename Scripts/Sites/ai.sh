#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/BardAI/BardAI.list"
    "rule/Surge/Claude/Claude.list"
    "rule/Surge/Copilot/Copilot.list"
    "rule/Surge/Gemini/Gemini.list"
    "rule/Surge/OpenAI/OpenAI.list"

    "https://ruleset.skk.moe/List/non_ip/ai.conf"
)

geosite_filenames=(
    "category-ai-!cn"

    "jetbrains-ai@!cn"
)

sites_common_handle "./result/surge/ai-domain.list" "./result/surge/ai-ruleset.list" "./result/list/ai-site.list" "./result/sing-box/ai-site.json" "./result/clash/ai-site.yaml"
