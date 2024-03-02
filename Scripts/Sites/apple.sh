#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

source ./Scripts/base.sh
source ./Scripts/Sites/common.sh

rule_set_urls=(
    "Clash/AppStore/AppStore.list"
    "Clash/Apple/Apple.list"
    "Clash/AppleDev/AppleDev.list"
    "Clash/AppleFirmware/AppleFirmware.list"
    "Clash/AppleHardware/AppleHardware.list"
    "Clash/AppleID/AppleID.list"
    "Clash/AppleMail/AppleMail.list"
    "Clash/AppleMedia/AppleMedia.list"
    "Clash/AppleMusic/AppleMusic.list"
    "Clash/AppleNews/AppleNews.list"
    "Clash/AppleProxy/AppleProxy.list"
    "Clash/AppleTV/AppleTV.list"
    "Clash/FindMy/FindMy.list"
    "Clash/FitnessPlus/FitnessPlus.list"
    "Clash/Siri/Siri.list"
    "Clash/SystemOTA/SystemOTA.list"
    "Clash/TestFlight/TestFlight.list"
    "Clash/iCloud/iCloud.list"
    "Clash/iCloudPrivateRelay/iCloudPrivateRelay.list"
)

geosite_filenames=(
    "apple@all"
)

sites_common_handle "./surge/apple-domain.list" "./surge/apple-ruleset.list" "./list/apple.list"
