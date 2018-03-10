#!/bin/bash
set -e
. setdevkitpath_x86.sh
export PATH=$ANDROID_DEVKIT/bin:$PATH

echo "Building Freetype"

cd freetype-2.6.2-x86
./configure \
	--host=i686-linux-android \
	--prefix=`pwd`/build_android-i686 \
	--without-zlib \
	--with-png=no \
	--with-harfbuzz=no

make -j4
make install
