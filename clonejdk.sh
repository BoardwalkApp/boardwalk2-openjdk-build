#!/bin/bash
# set -e
hg clone http://hg.openjdk.java.net/mobile/jdk9 openjdk
cd openjdk
bash ./get_source.sh

cd hotspot
hg import ../../termux-openjdk-aarch64-patches/hotspot/*.patch --no-commit

# print debug
cat src/os_cpu/linux_aarch64/vm/threadLS_linux_aarch64.s.rej
exit 255

cd ..
cd jdk
hg import ../../termux-openjdk-aarch64-patches/jdk/*.patch --no-commit

cd ..
hg import ../termux-openjdk-aarch64-patches/*.patch --no-commit
