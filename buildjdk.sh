#!/bin/bash
set -e
. setdevkitpath.sh
export FREETYPE_DIR=`pwd`/freetype-2.6.2/build_android-arm
export CUPS_DIR=`pwd`/cups-2.2.4

# My system's JDK is too old (7.0), so we add an Oracle boot JDK.
export PATH=`pwd`/jdk1.8.0_162/bin:$PATH

cd openjdk
rm -rf build
bash ./configure \
	--enable-option-checking=fatal \
	--build=x86_64-unknown-linux-gnu \
	--host=arm-linux-androideabi \
	--target=arm-linux-androideabi \
	--disable-warnings-as-errors \
	--enable-headless-only \
	--with-jdk-variant=normal \
	--with-cups-include=$CUPS_DIR \
	--with-devkit=$ANDROID_DEVKIT \
	--with-debug-level=release \
	--with-freetype-lib=$FREETYPE_DIR/lib \
	--with-freetype-include=$FREETYPE_DIR/include/freetype2

cd build/android-arm-normal-server-release
make JOBS=4 images
