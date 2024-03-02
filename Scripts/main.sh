#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

scripts=(
    "China/china.sh"
    "Overseas/overseas.sh"

    "Sites/360.sh"
    "Sites/alibaba.sh"
    "Sites/apple.sh"
    "Sites/baidu.sh"
    "Sites/bytedance.sh"
    "Sites/porn.sh"
    "Sites/tencent.sh"

    "Others/SharePoint.py"
    "Others/china-ip.sh"
    "Others/cmcc-ip.sh"
)

pip3 install -r ./Scripts/requirements.txt

git clone --depth=1 https://github.com/v2fly/domain-list-community.git
git clone --depth=1 https://github.com/blackmatrix7/ios_rule_script.git

for script in "${scripts[@]}"; do
    script_file="./Scripts/$script"
    chmod +x "$script_file"
    $script_file
done
