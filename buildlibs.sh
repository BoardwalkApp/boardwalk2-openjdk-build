#!/bin/bash
set -e
. setdevkitpath.sh
export PATH=$ANDROID_DEVKIT/bin:$PATH

echo "Building Freetype"

cd freetype-2.6.2
./configure \
	--host=aarch64-linux-android \
	--prefix=`pwd`/build_android-aarch64 \
	--without-zlib \
	--with-png=no \
	--with-harfbuzz=no
make -j4
make install

cd ..
echo "Building CUPS"

cd cups-2.2.4
./configure \
	--host=aarch64-linux-android \
	--prefix=`pwd`/build_android-aarch64
make -j4
make install
