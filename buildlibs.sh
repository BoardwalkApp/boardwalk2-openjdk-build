#!/bin/bash
set -e
. setdevkitpath.sh
cd freetype-$BUILD_FREETYPE_VERSION

echo "Building Freetype"

if [ "$BUILD_IOS" == "1" ]; then
  export CC=$thecc
  export CXX=$thecxx
  ./configure \
    --host=$TARGET \
    --prefix=`pwd`/build_android-${TARGET_SHORT} \
    --without-zlib \
    --with-brotli=no \
    --with-png=no \
    --with-harfbuzz=no \
    "CFLAGS=-arch arm64 -pipe -std=c99 -Wno-trigraphs -fpascal-strings -O2 -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -miphoneos-version-min=12.0 -I$thesysroot/usr/include/libxml2/ -isysroot $thesysroot" \
    AR=/usr/bin/ar \
    "LDFLAGS=-arch arm64 -isysroot $thesysroot -miphoneos-version-min=12.0" \
    || error_code=$?
else
  export PATH=$TOOLCHAIN/bin:$PATH
  ./configure \
    --host=$TARGET \
    --prefix=`pwd`/build_android-${TARGET_SHORT} \
    --without-zlib \
    --with-png=no \
    --with-harfbuzz=no $EXTRA_ARGS \
    || error_code=$?
fi
if [ "$error_code" -ne 0 ]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat config.log
  exit $error_code
fi

CFLAGS=-fno-rtti CXXFLAGS=-fno-rtti make -j4
make install

