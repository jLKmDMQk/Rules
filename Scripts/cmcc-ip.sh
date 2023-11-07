#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh

url="https://ispip.clang.cn/cmcc_cidr.txt"

wget -q -O $domain_raw_file $url

# Generate RouterOS RSC
echo "/ip firewall address-list remove [/ip firewall address-list find list=cmcc-ip-list]" >./routeros/cmcc-ip-list.rsc
echo "/ip firewall address-list" >>./routeros/cmcc-ip-list.rsc
cat $domain_raw_file | awk '{print "add address="$0" disabled=no list=cmcc-ip-list"}' >>./routeros/cmcc-ip-list.rsc
