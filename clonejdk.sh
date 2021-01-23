#!/bin/bash
set -e
if [ "$TARGET_JDK" == "arm" ]
then
git clone --depth 1 https://github.com/PojavLauncherTeam/openjdk-aarch64-jdk8u openjdk
else
git clone --depth 1 https://github.com/PojavLauncherTeam/openjdk-aarch32-jdk8u openjdk
fi
