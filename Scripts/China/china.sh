#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/China/config.sh

for url in "${rule_set_urls[@]}"; do
    handle_rule_set_to_domain_list "$url" "$domain_raw_file" "$domain_raw_list_file"
done

# for url in "${domain_list_urls[@]}"; do
#     handle_domain_list "$url" "$domain_raw_file" "$domain_raw_list_file"
# done

sort_and_deduplicate "$domain_raw_list_file" "$domain_list_file"

cp "$domain_list_file" ./surge/china-site-domain.list

handle_to_surge_domain_ruleset "$domain_list_file" "./surge/china-site-ruleset.list"

handle_to_common_domain_list "$domain_list_file" "./list/china-site.list"
