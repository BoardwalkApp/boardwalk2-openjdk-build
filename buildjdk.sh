#!/bin/bash
set -e
. setdevkitpath.sh
export FREETYPE_DIR=`pwd`/freetype-2.6.2/build_android-${TARGET_SHORT}
export CUPS_DIR=`pwd`/cups-2.2.4

# simplest to force headless:)
# export CPPFLAGS+=" -DHEADLESS=1" # -I$FREETYPE_DIR -I$CUPS_DIR
export LDFLAGS+=" -L`pwd`/dummy_libs -Wl,--warn-unresolved-symbols"

# It isn't good, but need make it build anyways
# cp -R $CUPS_DIR/* $ANDROID_INCLUDE/

# cp -R /usr/include/X11 $ANDROID_INCLUDE/
# cp -R /usr/include/fontconfig $ANDROID_INCLUDE/

ln -s /usr/include/X11 $ANDROID_INCLUDE/
ln -s /usr/include/fontconfig $ANDROID_INCLUDE/

# TODO remove after use got client to move them permanent
mkdir -p openjdk/jdk/src/share/native/common/unicode
mkdir -p openjdk/jdk/src/share/native/sun/font/layout/unicode
mv openjdk/jdk/src/share/native/sun/font/layout/unicode/* openjdk/jdk/src/share/native/common/unicode/

# Create dummy libraries so we won't have to remove them in OpenJDK makefiles
mkdir dummy_libs
ar cru dummy_libs/libpthread.a
ar cru dummy_libs/libthread_db.a

cd openjdk
rm -rf build

rm common/autoconf/generated_configure.sh

#	--with-extra-cxxflags="$CXXFLAGS -Dchar16_t=uint16_t -Dchar32_t=uint32_t" \
#	--with-extra-cflags="$CPPFLAGS" \
bash ./configure \
	--disable-headful \
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
