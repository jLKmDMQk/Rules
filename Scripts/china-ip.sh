#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh

url="https://github.com/Loyalsoldier/surge-rules/raw/release/cncidr.txt"

wget -q -O $domain_raw_file $url

cat $domain_raw_file | awk -F',' '{print $2}' >$domain_raw_list_file

cp $domain_raw_list_file ./list/china-ip.list

cp $domain_raw_file ./surge/china-ip-ruleset.list

cat $domain_raw_list_file | awk '{print "whitelist-ip "$0}' >./smartdns/whitelist-ip.conf


# Generate RouterOS RSC
echo "/ip firewall address-list remove [/ip firewall address-list find list=china-ip-list]" >./routeros/china-ip-list.rsc
echo "/ip firewall address-list" >> ./routeros/china-ip-list.rsc
cat $domain_raw_list_file | awk '{print "add address="$0" disabled=no list=china-ip-list"}' >> ./routeros/china-ip-list.rsc