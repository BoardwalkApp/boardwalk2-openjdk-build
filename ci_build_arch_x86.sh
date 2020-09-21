#!/bin/bash
set -e

export TARGET=i686-linux-android
export TARGET_SHORT=x86
export TARGET_JDK=x86

./ci_build_global.sh

