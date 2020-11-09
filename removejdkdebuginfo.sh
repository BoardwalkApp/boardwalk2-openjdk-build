#!/bin/bash
set -e
rm -rf jreout || true

cp -r openjdk/build/linux-${TARGET_JDK}-normal-server-${JDK_DEBUG_LEVEL}/images/j2re-image jreout
mv jreout/lib/${TARGET_JDK}/libfreetype.so.6 jreout/lib/${TARGET_JDK}/libfreetype.so || echo "Move exit $?"

# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep
# find jreout -name "*.diz" | xargs -- rm
# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep jreout/lib/${TARGET_JDK}/libfontmanager.diz

find jreout -name "libjvm.diz" | xargs -- rm
