#!/bin/bash
set -e
. setdevkitpath.sh
export FREETYPE_DIR=`pwd`/freetype-2.6.2/build_android-aarch64
export CUPS_DIR=`pwd`/cups-2.2.4/include
# /build_android-aarch64/include

# My system's JDK is too old (7.0), so we add an Oracle boot JDK.
# Set "USE_SYSTEM_JDK_8=1" to use system jdk instead
if [ -z "$USE_SYSTEM_JDK_8" ]
then
	export PATH=`pwd`/jdk1.8.0_162/bin:$PATH
fi

sudo apt -y install gcc-multilib g++-multilib

cd openjdk
rm -rf build
bash ./configure \
	--enable-option-checking=fatal \
	--host=x86_64-linux-gnu \
	--target=aarch64-linux-android \
	--disable-warnings-as-errors \
	--enable-headless-only \
	--with-jdk-variant=normal \
	--with-cups-include=$CUPS_DIR \
	--with-devkit=$ANDROID_DEVKIT \
	--with-debug-level=release \
	--with-freetype-lib=$FREETYPE_DIR/lib \
	--with-freetype-include=$FREETYPE_DIR/include/freetype2 \
        --x-includes=/usr/include \
        --x-libraries=/usr/lib \
  || error_code=$?
if [ "${error_code}" -ne 0 ]; then
  echo "\n\nCONFIGURE ERROR, config.log:"
  cat config.log
  exit $error_code
fi


cd build/android-aarch64-normal-server-release
make JOBS=4 images
