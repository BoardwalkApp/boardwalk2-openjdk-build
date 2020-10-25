#!/bin/bash
set -e
rm -rf jreout || true

# locate it:)
ls */*

echo "----- ls more -----"
ls */*/*

echo "----- ls more -----"
ls */*/*/*

cp -r openjdk/build/linux-${TARGET_JDK}-normal-server-release/jdk jreout
find jreout -name "*.diz" | xargs -- rm
