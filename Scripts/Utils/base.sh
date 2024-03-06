#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

temp_dir=$(mktemp -d)
domain_raw_file="$temp_dir/domain.raw"
domain_raw_list_file="$temp_dir/domain.raw.list"
domain_list_file="$temp_dir/domain.list"

function download_file() {
    url="$1"
    file_path="$2"

    if [ -f "$file_path" ]; then
        rm -f "$file_path"
    fi

    if [[ $url =~ ^https?:// ]]; then
        wget -q -O "$file_path" "$url"
    elif [[ $url == *"/"* ]]; then
        cat "./ios_rule_script/$url" >"$file_path"
    else
        python3 ./Scripts/Utils/geosite.py "$url" >"$file_path"
    fi
}

function handle_rule_set_to_domain_list() {
    url="$1"
    source_file_path="$2"
    target_file_path="$3"

    download_file "$url" "$source_file_path"

    cat $source_file_path | grep "DOMAIN-SUFFIX," | awk -F',' '{print "2\t."$2}' >>$target_file_path
    cat $source_file_path | grep "DOMAIN," | awk -F',' '{print "1\t"$2}' >>$target_file_path
}

function handle_rule_set() {
    url="$1"
    source_file_path="$2"
    target_file_path="$3"

    download_file "$url" "$source_file_path"

    # ruleset
    cat $source_file_path | grep "PROCESS-NAME," | awk -F',' '{print "1\t"$1","$2}' >>$target_file_path
    cat $source_file_path | grep "DOMAIN-KEYWORD," | awk -F',' '{print "3\t"$1","$2}' >>$target_file_path
    cat $source_file_path | grep "USER-AGENT," | awk -F',' '{print "2\t"$1","$2}' >>$target_file_path
}

function sort_and_deduplicate() {
    source_file_path="$1"
    target_file_path="$2"

    cat $source_file_path | grep -v "apple.com$" | sort | cut -f2- | uniq | sed '/^\s*$/d' | sed '/^$/d' >$target_file_path
}

function handle_to_surge_domain_ruleset() {
    source_file_path="$1"
    target_file_path="$2"

    cat "$source_file_path" | grep -ve "^\." | awk '{print "DOMAIN,"$0}' >$target_file_path
    cat "$source_file_path" | grep -e "^\." | sed 's/^\.//' | awk '{print "DOMAIN-SUFFIX,"$0}' >>$target_file_path
}

function handle_to_common_domain_list() {
    source_file_path="$1"
    target_file_path="$2"

    cat "$source_file_path" | sed 's/^\.//' >$target_file_path
}

function handle_domain_list() {
    url="$1"
    source_file_path="$2"
    target_file_path="$3"

    download_file "$url" "$source_file_path"

    cat $source_file_path | grep -ve "^\." | grep -v "#" | awk '{print "1\t"$0}' >>$target_file_path
    cat $source_file_path | grep -e "^\." | awk '{print "2\t"$0}' >>$target_file_path
}

function handle_clash_domain_rule_providers() {
    url="$1"
    source_file_path="$2"
    target_file_path="$3"

    download_file "$url" "$source_file_path"

    grep "\-\ " $source_file_path | sed 's/"//g' | sed "s/'//g" | sed 's/- +//' | sed 's/- //' >>$target_file_path
}
