# mediatek codec patch from hipexscape
if [ ! -f "frameworks/av/.mtk_codec_fix" ]; then
    curl -sL "https://raw.githubusercontent.com/hipexscape/Scripts/tsm/mediatek_codec_patch.sh" | bash
    touch frameworks/av/.mtk_codec_fix
fi

# if android.hardware.vibrator-service.mediatek is missing
if grep -q "android.hardware.vibrator-service.mediatek" out/error.log; then
    if [ ! -d "hardware/mediatek" ]; then
        git clone https://github.com/LineageOS/android_hardware_mediatek.git -b lineage-22.1 hardware/mediatek
    fi
    if [ -d "device/xiaomi/mt6768-common/vibrator" ]; then
        rm -rf device/xiaomi/mt6768-common/vibrator
    fi
    cp -rf hardware/mediatek/aidl/vibrator device/xiaomi/mt6768-common/
fi
