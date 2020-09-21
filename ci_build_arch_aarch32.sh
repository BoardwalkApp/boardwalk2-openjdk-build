#!/bin/bash
set -e

export TARGET=arm-linux-androideabi
export TARGET_SHORT=arm
export TARGET_JDK=aarch32

./ci_build_global.sh

