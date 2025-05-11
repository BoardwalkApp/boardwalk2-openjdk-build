#!/bin/bash
set -e
. setdevkitpath.sh
cd freetype-$BUILD_FREETYPE_VERSION

echo "Building Freetype"

if [[ "$BUILD_IOS" == "1" ]]; then
  LDFLAGS=-"arch arm64 -isysroot $thesysroot -miphoneos-version-min=12.0"
  export CC=$thecc
  export CXX=$thecxx
  ./configure \
    --host=$TARGET \
    --prefix=${PWD}/build_android-${TARGET_SHORT} \
    --enable-shared=no --enable-static=yes \
    --without-zlib \
    --with-brotli=no \
    --with-png=no \
    --with-harfbuzz=no \
    "CFLAGS=-arch arm64 -pipe -std=c99 -Wno-trigraphs -fpascal-strings -Os -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -miphoneos-version-min=12.0 -I$thesysroot/usr/include/libxml2/ -isysroot $thesysroot -DByte=uint8_t" \
    AR=/usr/bin/ar \
    "LDFLAGS=$LDFLAGS" \
    || error_code=$?
namefreetype=build_android-${TARGET_SHORT}/lib/libfreetype
else
  export PATH=$TOOLCHAIN/bin:$PATH
  ./configure \
    --host=$TARGET \
    --prefix=`pwd`/build_android-${TARGET_SHORT} \
    --without-zlib \
    --with-brotli=no \
    --with-png=no \
    --with-harfbuzz=no $EXTRA_ARGS \
    || error_code=$?
if [[ "$error_code" -ne 0 ]]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat config.log
  exit $error_code
fi
fi

CFLAGS=-fno-rtti CXXFLAGS=-fno-rtti make -j4
make install

if [[ -f "${namefreetype}.a" ]]; then
  clang -fPIC -shared $LDFLAGS -lbz2 -Wl,-all_load ${namefreetype}.a -o ${namefreetype}.dylib
fi
