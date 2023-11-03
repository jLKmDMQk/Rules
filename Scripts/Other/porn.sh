#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh

rule_providers_urls=(
    "https://rules.kr328.app/boboporn.yaml"
    "https://rules.kr328.app/category-porn.yaml"
    "https://rules.kr328.app/cavporn.yaml"
    "https://rules.kr328.app/dmm-porn.yaml"
    "https://rules.kr328.app/mindgeek-porn.yaml"
    "https://rules.kr328.app/pornhub.yaml"
    "https://rules.kr328.app/pornpros.yaml"
    "https://rules.kr328.app/theporndude.yaml"
    "https://rules.kr328.app/youporn.yaml"
)

rule_set_urls=(
    "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/Porn.list"
    "https://raw.githubusercontent.com/LM-Firefly/Rules/master/PROXY/Porn.list"
)

domain_2_raw_list_file="$temp_dir/domain.2.raw.list"
for url in "${rule_set_urls[@]}"; do
    handle_rule_set_to_domain_list "$url" "$domain_raw_file" "$domain_2_raw_list_file"
done
sort_and_deduplicate "$domain_2_raw_list_file" "$domain_raw_list_file"

for url in "${rule_providers_urls[@]}"; do
    handle_clash_domain_rule_providers "$url" "$domain_raw_file" "$domain_raw_list_file"
done

sort_and_deduplicate "$domain_raw_list_file" "$domain_list_file"

cp "$domain_list_file" ./surge/porn-site-domain.list

handle_to_surge_domain_ruleset "$domain_list_file" "./surge/porn-site-ruleset.list"

handle_to_common_domain_list "$domain_list_file" "./list/porn-site.list"
