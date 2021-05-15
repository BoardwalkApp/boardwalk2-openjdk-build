#!/bin/bash
set -e
if [ "$BUILD_IOS" == "1" ]; then
  export TARGET=aarch64-apple-darwin18.2
else
  export TARGET=aarch64-linux-android
fi
export TARGET_JDK=aarch64

bash ci_build_global.sh

