#!/bin/bash

#Add CCACHE Options
export USE_CCACHE=1
export CCACHE_DIR=/root/.ccache
export CXX="ccache g++"
export CC="ccache gcc"

export BUILD_JOB_NUMBER=$(grep processor /proc/cpuinfo | wc -l)
export CROSS_COMPILE=~/kernel/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
mkdir out
export ARCH=arm64
make -j$BUILD_JOB_NUMBER -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android flash_gts3llte_defconfig
make -j$BUILD_JOB_NUMBER -C $(pwd) O=$(pwd)/out KCFLAGS=-mno-android

cp out/arch/arm64/boot/Image $(pwd)/build/825/zImage
