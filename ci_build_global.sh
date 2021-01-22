#!/bin/bash
set -e

export JDK_DEBUG_LEVEL=release

apt-get update
./setdevkitpath.sh

wget -nc -nv -O android-ndk-$NDK_VERSION-linux-x86_64.zip "https://dl.google.com/android/repository/android-ndk-$NDK_VERSION-linux-x86_64.zip"
./extractndk.sh
./getlibs.sh
./maketoolchain.sh

# Some modifies to NDK to fix

./clonejdk.sh
./buildlibs.sh
./buildjdk.sh
./removejdkdebuginfo.sh
./tarjdk.sh
