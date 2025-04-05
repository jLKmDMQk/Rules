#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh

url="https://github.com/Loyalsoldier/surge-rules/raw/release/cncidr.txt"

wget -q -O $domain_raw_file $url

cat "$domain_raw_file" | awk -F',' '{print $2}' >$domain_raw_list_file

cp $domain_raw_list_file ./result/list/china-ip.list

cp "$domain_raw_file" ./result/surge/china-ip-ruleset.list

cat "$domain_raw_list_file" | awk '{print "whitelist-ip "$0}' >./result/smartdns/whitelist-ip.conf

# Generate JSON format
echo '{
  "version": 1,
  "rules": [
    {
      "ip_cidr": [' >./result/sing-box/china-ip.json
cat "$domain_raw_list_file" | awk '{print "        \""$0"\","}' | sed '$ s/,$//' >>./result/sing-box/china-ip.json
echo '      ]
    }
  ]
}' >>./result/sing-box/china-ip.json

# Generate RouterOS RSC
echo "/ip firewall address-list remove [/ip firewall address-list find list=china-ip-list]" >./result/routeros/china-ip-list.rsc
echo "/ip firewall address-list" >>./result/routeros/china-ip-list.rsc
cat "$domain_raw_list_file" | awk '{print "add address="$0" disabled=no list=china-ip-list"}' >>./result/routeros/china-ip-list.rsc
