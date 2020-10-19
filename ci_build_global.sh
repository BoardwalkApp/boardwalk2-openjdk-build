#!/bin/bash
set -e

if [ $TARGET_JDK == "aarch64" ]
then
  export TARGET_SHORT=arm64
else
  export TARGET_SHORT=$TARGET_JDK
fi

wget -nc -nv -O android-ndk-linux-x86_64.zip "https://dl.google.com/android/repository/android-ndk-r14-linux-x86_64.zip"
./extractndk.sh
./getlibs.sh
./maketoolchain.sh
./clonejdk.sh
./buildlibs.sh
./buildjdk.sh
./removejdkdebuginfo.sh
./tarjdk.sh
