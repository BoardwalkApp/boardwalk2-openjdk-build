#!/bin/bash
set -e
rm -rf jreout || true

# locate it:)
cd openjdk
tree
cd ..

cp -r openjdk/build/linux-${TARGET_JDK}-normal-server-release/images/j2re-image jreout
find jreout -name "*.diz" | xargs -- rm
