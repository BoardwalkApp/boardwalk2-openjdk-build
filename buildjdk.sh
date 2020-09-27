#!/bin/bash
set -e
. setdevkitpath.sh
export FREETYPE_DIR=`pwd`/freetype-2.6.2/build_android-${TARGET_SHORT}
export CUPS_DIR=`pwd`/cups-2.2.4

export CFLAGS+="-I$CUPS_DIR"
export CXXFLAGS+="-I$CUPS_DIR"

# My system's JDK is too old (7.0), so we add an Oracle boot JDK.
# Set "USE_SYSTEM_JDK_8=1" to use system jdk instead
if [ -z "$USE_SYSTEM_JDK_8" ]
then
	export PATH=`pwd`/jdk1.8.0_162/bin:$PATH
fi

sudo apt -y install gcc-multilib g++-multilib libxtst-dev libasound2-dev libelf-dev

# Patch for aarch64
cp -R -f override-jre-files/* openjdk/

cd openjdk
rm -rf build
bash ./configure \
	--enable-headless-only \
	--enable-option-checking=fatal \
	--openjdk-target=$TARGET \
	--disable-warnings-as-errors \
	--with-jdk-variant=normal \
	--with-cups-include=$CUPS_DIR \
	--with-devkit=$ANDROID_DEVKIT \
	--with-debug-level=release \
	--with-freetype-lib=$FREETYPE_DIR/lib \
	--with-freetype-include=$FREETYPE_DIR/include/freetype2 \
    --x-includes=/usr/include \
    --x-libraries=/usr/lib \
   || error_code=$?
if [ "$error_code" -ne 0 ]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat config.log
  exit $error_code
fi

mkdir -p build/android-${TARGET_JDK}-normal-server-release
cd build/android-${TARGET_JDK}-normal-server-release
make JOBS=4 images
