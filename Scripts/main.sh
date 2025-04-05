#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

scripts=(
    "AI-!CN/ai-!cn.sh"
    "China/china.sh"
    "China/china-max.sh"
    "Overseas/overseas.sh"
    \
    "Sites/360.sh"
    "Sites/ai.sh"
    "Sites/alibaba.sh"
    "Sites/apple.sh"
    "Sites/baidu.sh"
    "Sites/bilibili.sh"
    "Sites/bytedance.sh"
    "Sites/cryptocurrency.sh"
    "Sites/porn.sh"
    "Sites/speedtest.sh"
    "Sites/tencent.sh"
    \
    "Others/Github.py"
    "Others/SharePoint.py"
    "Others/china-ip.sh"
    "Others/cloudflare-ip.sh"
    "Others/cmcc-ip.sh"
    "Others/unicom_cnc-ip.sh"
    "Others/local-dns-mapping.py"
)

pip3 install -r ./Scripts/requirements.txt

mkdir -p ./dependence
git clone --depth=1 https://github.com/v2fly/domain-list-community.git ./dependence/domain-list-community
git clone --depth=1 https://github.com/blackmatrix7/ios_rule_script.git ./dependence/ios_rule_script

for script in "${scripts[@]}"; do
    script_file="./Scripts/$script"
    chmod +x "$script_file"
    $script_file
done
