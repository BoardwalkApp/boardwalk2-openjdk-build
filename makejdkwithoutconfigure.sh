#!/bin/bash
# duplicate of buildjdk.sh that avoids reconfiguring. Used for making changes to openjdk code.

set -e
. setdevkitpath.sh
export FREETYPE_DIR=`pwd`/freetype-2.6.2/build_android-arm64
export CUPS_DIR=`pwd`/cups-2.2.4

# My system's JDK is too old (7.0), so we add an Oracle boot JDK.
export PATH=`pwd`/jdk-9.0.4/bin:$PATH

cd openjdk
cd build/android-aarch64-normal-server-release
make JOBS=4 images
