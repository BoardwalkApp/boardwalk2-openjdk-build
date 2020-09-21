#!/bin/bash
set -e

export TARGET=aarch64-linux-android
export TARGET_SHORT=arm64
export TARGET_JDK=aarch64

./ci_build_global.sh

