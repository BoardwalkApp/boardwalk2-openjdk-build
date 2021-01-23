#!/bin/bash
set -e
. setdevkitpath.sh

if [ "$TARGET_JDK" == "arm" ]
then
  export TARGET_JDK=aarch32
  export TARGET_PHYS=aarch32-linux-gnueabi
else
  export TARGET_PHYS=$TARGET
fi

sudo apt -y install systemtap-sdt-dev gcc-multilib g++-multilib libxtst-dev libasound2-dev libelf-dev libfontconfig1-dev libx11-dev

export FREETYPE_DIR=`pwd`/freetype-$BUILD_FREETYPE_VERSION/build_android-${TARGET_SHORT}
export CUPS_DIR=`pwd`/cups-2.2.4

# simplest to force headless:)
export CFLAGS+=" -DDONT_COMPILE_SHENANDOAH -DLE_STANDALONE -DHEADLESS" # -I$FREETYPE_DIR -I$CUPS_DIR
export LDFLAGS+=" -L`pwd`/dummy_libs -Wl,--warn-unresolved-symbols"

# It isn't good, but need make it build anyways
# cp -R $CUPS_DIR/* $ANDROID_INCLUDE/

# cp -R /usr/include/X11 $ANDROID_INCLUDE/
# cp -R /usr/include/fontconfig $ANDROID_INCLUDE/

ln -s -f /usr/include/X11 $ANDROID_INCLUDE/
ln -s -f /usr/include/fontconfig $ANDROID_INCLUDE/

# Create dummy libraries so we won't have to remove them in OpenJDK makefiles
mkdir -p dummy_libs
ar cru dummy_libs/libpthread.a
ar cru dummy_libs/libthread_db.a

cd openjdk
rm -rf build

#	--with-extra-cxxflags="$CXXFLAGS -Dchar16_t=uint16_t -Dchar32_t=uint32_t" \
#	--with-extra-cflags="$CPPFLAGS" \
bash ./configure \
	--disable-headful \
	--with-extra-cflags="$CFLAGS" \
	--with-extra-cxxflags="$CFLAGS" \
	--with-extra-ldflags="$LDFLAGS" \
	--enable-option-checking=fatal \
	--openjdk-target=$TARGET_PHYS \
	--with-jdk-variant=normal \
        --with-jvm-variants=$JVM_VARIANTS \
	--with-cups-include=$CUPS_DIR \
	--with-devkit=$TOOLCHAIN \
	--with-debug-level=$JDK_DEBUG_LEVEL \
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

# mkdir -p build/linux-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}
cd build/linux-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}
make JOBS=4 images || \
error_code=$?
if [ "$error_code" -ne 0 ]; then
  echo "Build failure, exited with code $error_code. Trying again."
  make JOBS=4 images
fi
