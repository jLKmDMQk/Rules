#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

function sites_common_handle() {
    target_1_file="$1"
    target_2_file="$2"
    target_3_file="$3"

    for url in "${rule_set_urls[@]}"; do
        handle_rule_set_to_domain_list "$url" "$domain_raw_file" "$domain_raw_list_file"
    done

    if [ ${#domain_list_urls[@]} -gt 0 ]; then
        for url in "${domain_list_urls[@]}"; do
            handle_domain_list "$url" "$domain_raw_file" "$domain_raw_list_file"
        done
    fi

    if [ ${#geosite_filenames[@]} -gt 0 ]; then
        for filename in "${geosite_filenames[@]}"; do
            python3 ./Scripts/geosite.py "$filename" > "$domain_raw_file"
            handle_rule_set_to_domain_list "" "$domain_raw_file" "$domain_raw_list_file"
        done
    fi

    sort_and_deduplicate "$domain_raw_list_file" "$domain_list_file"

    cp "$domain_list_file" $target_1_file

    handle_to_surge_domain_ruleset "$domain_list_file" "$target_2_file"

    handle_to_common_domain_list "$domain_list_file" "$target_3_file"
}
