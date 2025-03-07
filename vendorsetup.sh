LOS_VER="22.1"

# mediatek codec patch from hipexscape
if [ ! -f "frameworks/av/.mtk_codec_fix" ]; then
    curl -sL "https://raw.githubusercontent.com/hipexscape/Scripts/tsm/mediatek_codec_patch.sh" | bash
    touch frameworks/av/.mtk_codec_fix
fi

# Remove FMRadio
if [ -d "packages/apps/FMRadio" ]; then
  rm -rf "packages/apps/FMRadio"
fi

# Dolby
if [ ! -d "hardware/xiaomi/dolby" ]; then
  rm -rf "hardware/xiaomi/"
  echo "Dolby not found, cloning new hardware/xiaomi"
  git clone https://github.com/Ksawlii-Android-Repos/hardware_xiaomi.git -b "lineage-$LOS_VER" "hardware/xiaomi/"
fi
