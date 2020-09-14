#!/bin/bash
set -e
. setdevkitpath.sh
export FREETYPE_DIR=`pwd`/freetype-2.6.2/build_android-aarch64
export CUPS_DIR=`pwd`/cups-2.2.4

# My system's JDK is too old (7.0), so we add an Oracle boot JDK.
# Set "USE_SYSTEM_JDK_8=1" to use system jdk instead
if [ -z "$USE_SYSTEM_JDK_8" ]
then
	export PATH=`pwd`/jdk1.8.0_162/bin:$PATH
fi

sudo apt -y install gcc-multilib g++-multilib libxtst-dev libasound2-dev libelf-dev

cd openjdk
rm -rf build
bash ./configure \
	--enable-option-checking=fatal \
        --build=x86_64-linux-gnu \
        --host=aarch64-linux-android \
	--target=aarch64-linux-android \
	--disable-warnings-as-errors \
	--enable-headless-only \
	--with-jdk-variant=normal \
	--with-cups-include=$CUPS_DIR \
	--with-devkit=$ANDROID_DEVKIT \
	--with-debug-level=release \
	--with-freetype-lib=$FREETYPE_DIR/lib \
	--with-freetype-include=$FREETYPE_DIR/include/freetype2 \
	--with-toolchain-type=clang \
        --x-includes=/usr/include \
        --x-libraries=/usr/lib \
   || error_code=$?
if [ "$error_code" -ne 0 ]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat config.log

# remove later
sudo apt -y install silversearcher-ag
echo "--- BEGIN SEARCH ---"
ag "\-march=i686"
echo "--- ENDED SEARCH ---"

  exit $error_code
fi

mkdir -p build/android-aarch64-normal-server-release
cd build/android-aarch64-normal-server-release
make JOBS=4 images
