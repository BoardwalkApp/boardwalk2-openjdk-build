#!/bin/bash
set -e
android-ndk-r15/build/tools/make-standalone-toolchain.sh \
	--arch=x86 \
	--platform=android-21 \
	--install-dir=`pwd`/android-ndk-r10e/generated-toolchains/android-x86-toolchain
cp devkit.info.x86 android-ndk-r10e/generated-toolchains/android-x86-toolchain/
