#!/bin/bash
set -e
if [ "$TARGET_JDK" == "arm" ]; then
git clone --depth 1 https://github.com/openjdk/aarch32-port-jdk8u openjdk
elif [ "$BUILD_IOS" == "1" ]; then
git clone --depth 1 --branch ios https://github.com/PojavLauncherTeam/openjdk-multiarch-jdk8u openjdk
else
# Use aarch32 repo because it also has aarch64

git clone --depth 1 https://github.com/PojavLauncherTeam/jdk8u openjdk
fi
