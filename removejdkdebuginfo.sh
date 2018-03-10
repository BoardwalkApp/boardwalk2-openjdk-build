#!/bin/bash
set -e
rm -rf jreout || true
cp -r openjdk/build/android-arm-normal-server-release/images/jre jreout
find jreout -name "*.diz" | xargs -- rm
