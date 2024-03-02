#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/Utils/base.sh

wget -q -O $domain_raw_file "https://ispip.clang.cn/cmcc_cidr.txt"
cat $domain_raw_file >>$domain_raw_list_file
echo "" >>$domain_raw_list_file

wget -q -O $domain_raw_file "https://ispip.clang.cn/crtc_cidr.txt"
cat $domain_raw_file >>$domain_raw_list_file
echo "" >>$domain_raw_list_file

cat $domain_raw_list_file | grep -v "^[[:space:]]*$" >>$domain_list_file

# Generate RouterOS RSC
echo "/ip firewall address-list remove [/ip firewall address-list find list=cmcc-ip-list]" >./routeros/cmcc-ip-list.rsc
echo "/ip firewall address-list" >>./routeros/cmcc-ip-list.rsc
cat $domain_list_file | awk '{print "add address="$0" disabled=no list=cmcc-ip-list"}' >>./routeros/cmcc-ip-list.rsc
