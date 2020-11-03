#!/bin/bash
set -e
. setdevkitpath.sh
export PATH=$TOOLCHAIN/bin:$PATH

echo "Building Freetype"

cd freetype-2.6.2
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

CFLAGS=-fno-rtti CXXFLAGS=-fno-rtti make -j4 | \
sudo apt -y install systemtap-sdt-dev gcc-multilib g++-multilib libxtst-dev libasound2-dev libelf-dev libfontconfig1-dev libx11-dev

make install

