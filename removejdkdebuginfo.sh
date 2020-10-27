#!/bin/bash
set -e
rm -rf jreout || true

cp -r openjdk/build/linux-${TARGET_JDK}-normal-server-${JDK_DEBUG_LEVEL}/images/j2re-image jreout
find jreout -name "*.diz" | xargs -- rm
