# Simple Script for building ROM, Especially Crave.

# Clean up
rm -rf .repo hardware/xiaomi

# Do repo init for rom that we want to build.
repo init -u https://github.com/protonplus-org/manifest -b tm-qpr3  --git-lfs --depth=1 --no-repo-verify

# Remove tree before cloning our manifest.
rm -rf device/xiaomi/ vendor/xioami kernel/xiaomi packages/resources/devicesettings system/core

# Clone our trees.
git clone https://github.com/zaidannn7/pohon -b 13 device/xiaomi/chime
git clone https://github.com/zaidannn7/vemdor -b 13 vendor/xiaomi/chime
git clone https://github.com/hac4us06/vendor_xiaomi_citrus -b 13 vendor/xiaomi/citrus
git clone https://github.com/hac4us06/vendor_xiaomi_lime -b 13 vendor/xiaomi/lime
git clone https://github.com/hac4us06/kernel-xiaomi-electro -b 14 kernel/xiaomi/chime

# Let's sync!
/opt/crave/resync.sh

# Additional some source tree things

# Do lunch
. build/envsetup.sh
lunch lime-userdebug

# Define build username and hostname things, also kernel
export BUILD_USERNAME=zaidan
export BUILD_HOSTNAME=authority    
export SKIP_ABI_CHECKS=true
#export ALLOW_MISSING_DEPENDENCIES=true
#export RELAX_USES_LIBRARY_CHECK=true
#export BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES=true
#export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
#export BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE=true
#export BUILD_BROKEN_VERIFY_USES_LIBRARIES=true
#export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
#export BUILD_BROKEN_DUP_RULES=true
export KBUILD_BUILD_USER=zaidan    
export KBUILD_BUILD_HOST=authority
#export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
#export BUILD_BROKEN_INCORRECT_PARTITION_IMAGES=true

# Let's start build!
make bacon
