#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

scripts=(
    "china-ip.sh"
    "China/china.sh"
    "Overseas/overseas.sh"
    "Sites/360.sh"
    "Sites/apple.sh"
    "Sites/alibaba.sh"
    "Sites/baidu.sh"
    "Sites/bytedance.sh"
    "Sites/tencent.sh"
    "Other/porn.sh"
)

for script in ${scripts[@]}; do
    script_file="./Scripts/$script"
    chmod +x $script_file
    $script_file
done
