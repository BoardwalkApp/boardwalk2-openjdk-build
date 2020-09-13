#!/bin/bash
set -e
. setdevkitpath.sh
export PATH=$ANDROID_DEVKIT/bin:$PATH

echo "Building Freetype"

cd freetype-2.6.2
freetype_build_out=`./configure \
	--host=aarch64-linux-android \
	--prefix=`pwd`/build_android-aarch64 \
	--without-zlib \
	--with-png=no \
	--with-harfbuzz=no \
&& \
make -j4 && \
make install` || error_code=$?

if [ "${error_code}" -ne 0 ]; then
  echo $freetype_build_out
  exit $error_code
else
  echo "Done build freetype"
fi
