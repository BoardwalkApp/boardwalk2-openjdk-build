#!/bin/bash
set -e

export TARGET=arm-linux-gnueabi
export TARGET_JDK=arm

bash ci_build_global.sh

