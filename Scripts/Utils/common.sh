#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

function sites_common_handle() {
    target_1_file="$1"
    target_2_file="$2"
    target_3_file="$3"
    target_4_file="$4"
    target_5_file="$5"

    if [ ${#rule_set_urls[@]} -gt 0 ]; then
        for url in "${rule_set_urls[@]}"; do
            handle_rule_set_to_domain_list "$url" "$domain_raw_file" "$domain_raw_list_file"
        done
    fi

    if [ ${#domain_list_urls[@]} -gt 0 ]; then
        for url in "${domain_list_urls[@]}"; do
            handle_domain_list "$url" "$domain_raw_file" "$domain_raw_list_file"
        done
    fi

    if [ ${#geosite_filenames[@]} -gt 0 ]; then
        for filename in "${geosite_filenames[@]}"; do
            handle_rule_set_to_domain_list "$filename" "$domain_raw_file" "$domain_raw_list_file"
        done
    fi

    if [ ${#excluded_geosite_filenames[@]} -gt 0 ]; then
        excluded_domain_raw_list_file="$temp_dir/domain.excluded.raw.list"
        for filename in "${excluded_geosite_filenames[@]}"; do
            handle_rule_set_to_domain_list "$filename" "$domain_raw_file" "$excluded_domain_raw_list_file"
        done

        awk -F '\t' '
            NR == FNR {
                domain = $2
                if (sub(/^\./, "", domain)) {
                    excluded_suffixes[domain] = 1
                } else {
                    excluded_domains[domain] = 1
                }
                next
            }
            {
                domain = $2
                sub(/^\./, "", domain)
                excluded = domain in excluded_domains
                suffix = domain
                while (!excluded) {
                    if (suffix in excluded_suffixes) {
                        excluded = 1
                        break
                    }
                    if (!sub(/^[^.]+\./, "", suffix)) {
                        break
                    }
                }
                if (!excluded) {
                    print
                }
            }
        ' "$excluded_domain_raw_list_file" "$domain_raw_list_file" >"$domain_raw_file"
        cp "$domain_raw_file" "$domain_raw_list_file"
    fi

    sort_and_deduplicate "$domain_raw_list_file" "$domain_list_file"

    if [ -n "$target_1_file" ]; then
        cp "$domain_list_file" "$target_1_file"
    fi

    if [ -n "$target_2_file" ]; then
        handle_to_surge_domain_ruleset "$domain_list_file" "$target_2_file"
    fi

    if [ -n "$target_3_file" ]; then
        handle_to_common_domain_list "$domain_list_file" "$target_3_file"
    fi

    if [ -n "$target_4_file" ]; then
        handle_to_sing_box_rule_set "$domain_list_file" "$target_4_file"
    fi

    if [ -n "$target_5_file" ]; then
        handle_to_clash_domain_rule_providers "$domain_list_file" "$target_5_file"
    fi
}
