#!/bin/bash
set -e
. setdevkitpath.sh
export PATH=$ANDROID_DEVKIT/bin:$PATH

echo "Building Freetype"

cd freetype-2.6.2
./configure \
	--host=arm-linux-androideabi \
	--prefix=`pwd`/build_android-arm \
	--without-zlib \
	--with-png=no \
	--with-harfbuzz=no

make -j4
make install
