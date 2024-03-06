#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh
source ./Scripts/Utils/common.sh

rule_set_urls=(
    "rule/Surge/BardAI/BardAI.list"
    "rule/Surge/Copilot/Copilot.list"
    "rule/Surge/Gemini/Gemini.list"
    "rule/Surge/OpenAI/OpenAI.list"
)

geosite_filenames=(
    "openai"
    "jetbrains-ai@!cn"
)

sites_common_handle "./surge/ai-domain.list" "./surge/ai-ruleset.list" "./list/ai-site.list"
