LOS_VERSION="lineage-22.1"

# mediatek codec patch from hipexscape
if [ ! -f "frameworks/av/.mtk_codec_fix" ]; then
    curl -sL "https://raw.githubusercontent.com/hipexscape/Scripts/tsm/mediatek_codec_patch.sh" | bash
    touch frameworks/av/.mtk_codec_fix
fi

# Fix FMRadio
if [ -d "packages/apps/FMRadio" ] && [ ! -f "packages/apps/FMRadio/.fixed-fmr" ]; then
  rm -rf "packages/apps/FMRadio"
  echo "Removed existing FMRadio, cloning new one..."
fi

if [ ! -f "packages/apps/FMRadio/.fixed-fmr" ]; then
  git clone https://github.com/LineageOS/android_packages_apps_FMRadio -b $LOS_VERSION "packages/apps/FMRadio"
  cd "packages/apps/FMRadio"
  echo ""
  echo "Fixing FMRadio..."
  git revert --no-edit f3eb07a311caf15f4f86f8f4dd6a221d61757aed
  touch ".fixed-fmr"
  echo ".fixed-fmr" > .gitignore
  echo ""
  echo "Fixed FMRadio"
  cd ../../../
fi

# if libfmjni is undefined
if [ -f "out/error.log" ]; then
  if grep -r -w "libfmjni" out/error.log; then
    cd vendor/xiaomi/mt6768-common
    if [ -f .git/shallow ]; then
      git pull --unshallow
      git revert --no-edit 0f711e758c005a41fcc396ba14ad89b557fb402b
    else
      git revert --no-edit 0f711e758c005a41fcc396ba14ad89b557fb402b 
    fi
    rm -rf "out/error.log"
    cd ../../../
  fi
fi

# Remove kernel headers conflicts
if [ -d "hardware/google/pixel/kernel_headers/" ]; then
  rm -rf "hardware/google/pixel/kernel_headers/"
fi

# Remove PowerOffAlarm
if [ -d "hardware/mediatek/PowerOffAlarm/" ]; then
  rm -rf "hardware/mediatek/PowerOffAlarm/"
fi
