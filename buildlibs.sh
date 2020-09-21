#!/bin/bash
set -e
. setdevkitpath.sh
export PATH=$ANDROID_DEVKIT/bin:$PATH

echo "Building Freetype"

cd freetype-2.6.2
./configure \
	--host=$TARGET \
	--prefix=`pwd`/build_android-${TARGET_SHORT} \
	--without-zlib \
	--with-png=no \
	--with-harfbuzz=no
make -j4
make install

