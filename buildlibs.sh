#!/bin/bash
set -e
. setdevkitpath.sh
export PATH=$TOOLCHAIN/bin:$PATH

echo "Building Freetype"

cd freetype-$BUILD_FREETYPE_VERSION
./configure \
	--host=$TARGET \
	--prefix=`pwd`/build_android-${TARGET_SHORT} \
	--without-zlib \
	--with-png=no \
	--with-harfbuzz=no || \
error_code=$?
if [ "$error_code" -ne 0 ]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat config.log
  exit $error_code
fi

CFLAGS=-fno-rtti CXXFLAGS=-fno-rtti make -j4
make install

