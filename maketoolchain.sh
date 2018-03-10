#!/bin/bash
set -e
android-ndk-r10e/build/tools/make-standalone-toolchain.sh \
	--arch=arm \
	--platform=android-21 \
	--install-dir=`pwd`/android-ndk-r10e/generated-toolchains/android-arm-toolchain
cp devkit.info.arm android-ndk-r10e/generated-toolchains/android-arm-toolchain/
