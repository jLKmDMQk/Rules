#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

rule_set_urls=(
    "rule/Surge/BardAI/BardAI.list"
    "rule/Surge/Copilot/Copilot.list"
    "rule/Surge/Cryptocurrency/Cryptocurrency.list"
    "rule/Surge/Gemini/Gemini.list"
    "rule/Surge/OpenAI/OpenAI.list"

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
    "category-ecommerce@!cn"
    "category-entertainment@!cn"
    "category-ipfs@!cn"
    "category-media@!cn"
    "category-porn@!cn"
    "category-scholar-!cn@!cn"
    "category-social-media-!cn@!cn"

    "cloudflare@!cn"
    "docker@!cn"
    "gitbook@!cn"
    "github@!cn"z
    "gitlab@!cn"
    "google@!cn"
    "jetbrains-ai@!cn"
    "jetbrains@!cn"
    "openai@!cn"
    "stackexchange@!cn"
)
