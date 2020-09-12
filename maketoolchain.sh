#!/bin/bash
set -e

bash setdevkitpath.sh

$NDK_HOME/build/tools/make-standalone-toolchain.sh \
	--arch=arm64 \
	--platform=android-21 \
	--install-dir=$NDK_HOME/generated-toolchains/android-arm64-toolchain
cp devkit.info.arm64 $NDK_HOME/generated-toolchains/android-arm64-toolchain/
