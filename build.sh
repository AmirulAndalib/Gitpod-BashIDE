#!/bin/bash
git config --global user.email rokibhasansagar2014@outlook.com
git config --global user.name rokibhasansagar
git config --global credential.helper store
git config --global color.ui true
[ ! -d /home/builder ] && mkdir -p /home/builder 2>/dev/null
cd /home/builder
mkdir -p droid
cd droid
printf "Initializing PBRP repo sync...\n\n"
repo init -q -u https://github.com/PitchBlackRecoveryProject/manifest_pb.git -b android-9.0 --depth 1
repo sync -c -q --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
rm -rf development/apps/ development/samples/ packages/apps/ 2>/dev/null
cp vendor/utils/pb_build.sh vendor/pb/pb_build.sh 2>/dev/null && chmod +x vendor/pb/pb_build.sh
export VENDOR="xiaomi" CODENAME="whyred" TEST_BUILD=true PB_ENGLISH=true VERSION="3.0.0"
git clone https://github.com/PitchBlackRecoveryProject/android_device_xiaomi_whyred-pbrp -b android-9.0 device/${VENDOR}/${CODENAME}
printf "Repo synced at %s\n\n" "$(pwd)"
cd /home/builder/droid
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch omni_${CODENAME}-eng
make -j$(nproc --all) recoveryimage
