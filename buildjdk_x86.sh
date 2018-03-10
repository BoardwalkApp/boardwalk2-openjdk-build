#!/bin/bash
set -e
. setdevkitpath_x86.sh
export FREETYPE_DIR=`pwd`/freetype-2.6.2-x86/build_android-i686
export CUPS_DIR=`pwd`/cups-2.2.4

# My system's JDK is too old (7.0), so we add an Oracle boot JDK.
export PATH=`pwd`/jdk1.8.0_162/bin:$PATH

cd openjdk
#rm -rf build
bash ./configure \
	--enable-option-checking=fatal \
	--build=x86_64-unknown-linux-gnu \
	--host=i686-linux-android \
	--target=i686-linux-android \
	--disable-warnings-as-errors \
	--enable-headless-only \
	--with-jdk-variant=normal \
	--with-jvm-variants=server \
	--with-cups-include=$CUPS_DIR \
	--with-devkit=$ANDROID_DEVKIT \
	--with-debug-level=release \
	--with-freetype-lib=$FREETYPE_DIR/lib \
	--with-freetype-include=$FREETYPE_DIR/include/freetype2

cd build/android-x86-normal-server-release
make JOBS=4 images
