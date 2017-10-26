#!/bin/bash
# red = errors, cyan = warnings, green = confirmations, blue = informational
# plain for generic text, bold for titles, reset flag at each end of line
# plain blue should not be used for readability reasons - use plain cyan instead
CLR_RST=$(tput sgr0)                        ## reset flag
CLR_RED=$CLR_RST$(tput setaf 1)             #  red, plain
CLR_GRN=$CLR_RST$(tput setaf 2)             #  green, plain
CLR_BLU=$CLR_RST$(tput setaf 4)             #  blue, plain
CLR_CYA=$CLR_RST$(tput setaf 6)             #  cyan, plain
CLR_BLD=$(tput bold)                        ## bold flag
CLR_BLD_RED=$CLR_RST$CLR_BLD$(tput setaf 1) #  red, bold
CLR_BLD_GRN=$CLR_RST$CLR_BLD$(tput setaf 2) #  green, bold
CLR_BLD_BLU=$CLR_RST$CLR_BLD$(tput setaf 4) #  blue, bold
CLR_BLD_CYA=$CLR_RST$CLR_BLD$(tput setaf 6) #  cyan, bold

# Check the starting time (of the real build process)
TIME_START=$(date +%s.%N)

#Add CCACHE Options
export USE_CCACHE=1
export CCACHE_DIR=/root/.ccache
export CXX="ccache g++"
export CC="ccache gcc"

make mrproper
rm -r -f out

export BUILD_JOB_NUMBER=$(grep processor /proc/cpuinfo | wc -l)
export CROSS_COMPILE=~/kernel/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
mkdir out
export ARCH=arm64
make -j$BUILD_JOB_NUMBER -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android flash_gts3lwifi_defconfig
make -j$BUILD_JOB_NUMBER -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android
cp out/arch/arm64/boot/Image $(pwd)/build/820/zImage

cd $(pwd)/build/820
zip -r9 Flash-KernelV1.0.zip * -x README Flash-KernelV1.0.zip

# Check the finishing time
TIME_END=$(date +%s.%N)

# Log those times at the end as a fun fact of the day
echo -e "${CLR_BLD_GRN}Total time elapsed:${CLR_RST} ${CLR_GRN}$(echo "($TIME_END - $TIME_START) / 60" | bc) minutes ($(echo "$TIME_END - $TIME_START" | bc) seconds)${CLR_RST}"
echo -e ""
