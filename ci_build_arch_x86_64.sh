#!/bin/bash
set -e

export TARGET=x86_64-linux-android
export TARGET_SHORT=x86_64
export TARGET_JDK=amd64

bash ci_build_global.sh

