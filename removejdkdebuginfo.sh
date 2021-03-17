#!/bin/bash
set -e
rm -rf jreout || true

if [ "$TARGET_JDK" == "arm" ]
then
  export TARGET_JDK=aarch32
fi

mkdir dizout

cp -r openjdk/build/linux-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}/images/j2re-image jreout
cp -r openjdk/build/linux-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}/images/j2sdk-image jdkout
mv jreout/lib/${TARGET_JDK}/libfreetype.so.6 jreout/lib/${TARGET_JDK}/libfreetype.so || echo "Move exit $?"

# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep
# find jreout -name "*.diz" | xargs -- rm
# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep jreout/lib/${TARGET_JDK}/libfontmanager.diz

find jdkout -name "*.diz" | xargs -- rm
find jreout -name "*.diz" -exec mv {} dizout/
