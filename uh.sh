# Simple Script for building ROM, Especially Crave.

# Clean up
rm -rf hardware/xiaomi

# Do repo init for rom that we want to build.
repo init -u https://github.com/protonplus-org/manifest -b tm-qpr3  --git-lfs --depth=1 --no-repo-verify

# Remove tree before cloning our manifest.
rm -rf device/xiaomi android vendor hardware packages vendor/gms vendor/xioami kernel/xiaomi packages/resources/devicesettings system/core

# Clone our trees.
git clone https://github.com/zaidannn7/pohon -b 13 device/xiaomi/chime
git clone https://github.com/hac4us06/vendor_xiaomi_chime -b 13 vendor/xiaomi/chime
git clone https://github.com/hac4us06/vendor_xiaomi_citrus -b 13 vendor/xiaomi/citrus
git clone https://github.com/hac4us06/vendor_xiaomi_lime -b 13 vendor/xiaomi/lime
git clone https://github.com/zaidanalt/qcom_sm6115 -b zeta kernel/xiaomi/chime


# Let's sync!
/opt/crave/resync.sh

# Additional some source tree things
rm -rf frameworks/base 
git clone -b tm-qpr3 https://github.com/newestzdn/frameworkbase --depth=1 frameworks/base

rm -rf bionic
git clone -b tm-qpr3 https://github.com/newestzdn/bionic --depth=1 bionic

# Do lunch
. build/envsetup.sh
lunch lime-user


# Define build username and hostname things, also kernel
export BUILD_USERNAME=zaidan
export BUILD_HOSTNAME=authority    
export SKIP_ABI_CHECKS=true
export KBUILD_BUILD_USER=zaidan    
export KBUILD_BUILD_HOST=authority

# Let's start build!
m otapackage
