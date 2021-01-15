#!/bin/bash
set -e

export TARGET=arm-linux-androideabi
export TARGET_JDK=aarch32

bash ci_build_global.sh

