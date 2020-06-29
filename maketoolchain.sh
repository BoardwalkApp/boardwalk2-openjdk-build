#!/bin/bash
set -e
android-ndk-r10e/build/tools/make-standalone-toolchain.sh \
	--arch=arm64 \
	--platform=android-21 \
	--install-dir=`pwd`/android-ndk-r10e/generated-toolchains/android-arm64-toolchain
cp devkit.info.arm64 android-ndk-r10e/generated-toolchains/android-arm-toolchain/
