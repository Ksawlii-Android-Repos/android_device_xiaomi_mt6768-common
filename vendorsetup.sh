# mediatek codec patch from hipexscape
if [ ! -f "frameworks/av/.mtk_codec_fix" ]; then
    curl -sL "https://raw.githubusercontent.com/hipexscape/Scripts/tsm/mediatek_codec_patch.sh" | bash
    touch frameworks/av/.mtk_codec_fix
fi

if [ -d "packages/apps/FMRadio" ]; then
    rm -rf "packages/apps/FMRadio"
fi
