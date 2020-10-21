#!/bin/bash
set -e
. setdevkitpath.sh
export FREETYPE_DIR=`pwd`/freetype-2.6.2/build_android-${TARGET_SHORT}
export CUPS_DIR=`pwd`/cups-2.2.4

# simplest to force headless:)
export CPPFLAGS+=" -I$FREETYPE_DIR -I$CUPS_DIR -DHEADLESS"

# It isn't good, but need make it build anyways
cp -R $CUPS_DIR/* $ANDROID_INCLUDE/

sudo apt -y install systemtap-sdt-dev gcc-multilib g++-multilib libxtst-dev libasound2-dev libelf-dev libfontconfig1-dev libx11-dev

cp -R /usr/include/X11 $ANDROID_INCLUDE/
cp -R /usr/include/fontconfig $ANDROID_INCLUDE/

# Create dummy libraries so we won't have to remove them in OpenJDK makefiles
mkdir dummy_libs
ar cru dummy_libs/libpthread.a
ar cru dummy_libs/libthread_db.a
export LDFLAGS+=" -L`pwd`/dummy_libs"

cd openjdk
rm -rf build
#	--with-extra-cxxflags="$CXXFLAGS --std=c++11" \
bash ./configure \
	--with-extra-cflags="$CPPFLAGS" \
	--with-extra-ldflags="$LDFLAGS" \
	--enable-option-checking=fatal \
	--openjdk-target=$TARGET \
	--with-jdk-variant=normal \
	--with-cups-include=$CUPS_DIR \
	--with-devkit=$ANDROID_DEVKIT \
	--with-debug-level=release \
	--with-fontconfig-include=$ANDROID_INCLUDE \
	--with-freetype-lib=$FREETYPE_DIR/lib \
	--with-freetype-include=$FREETYPE_DIR/include/freetype2 \
	--x-includes=$ANDROID_INCLUDE \
	--x-libraries=/usr/lib || \
error_code=$?
if [ "$error_code" -ne 0 ]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat config.log
  exit $error_code
fi

mkdir -p build/linux-${TARGET_JDK}-normal-server-release
cd build/linux-${TARGET_JDK}-normal-server-release
make JOBS=4 images
