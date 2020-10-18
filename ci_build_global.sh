#!/bin/bash
set -e

wget -nc -nv -O android-ndk-r10e-linux-x86_64.zip "https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip"
./extractndk.sh
./getlibs.sh
./maketoolchain.sh
./clonejdk.sh
./buildlibs.sh
./buildjdk.sh
./removejdkdebuginfo.sh
./tarjdk.sh
