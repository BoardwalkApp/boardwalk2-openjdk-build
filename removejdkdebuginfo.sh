#!/bin/bash
set -e

if [ "$TARGET_JDK" == "arm" ]; then
  export TARGET_JDK=aarch32
fi

imagespath=openjdk/build/${JVM_PLATFORM}-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}/images

rm -rf dizout jreout jdkout
mkdir dizout

if [ "$BUILD_IOS" == "1" ]; then
  find $imagespath -name "*.dylib" -exec ldid -Sios-sign-entitlements.xml {} \;
  for bindir in $(find $imagespath -name "bin"); do
    ldid -Sios-sign-entitlements.xml ${bindir}/*
  done
fi

cp -r $imagespath/j2re-image jreout
cp -r $imagespath/j2sdk-image jdkout

mv jdkout/lib/${TARGET_JDK}/libfreetype.so.6 jdkout/lib/${TARGET_JDK}/libfreetype.so || echo "Move exit $?"
mv jdkout/lib/${TARGET_JDK}/libfreetype.dylib.6 jdkout/lib/${TARGET_JDK}/libfreetype.dylib || echo "Move exit $?"
mv jreout/lib/${TARGET_JDK}/libfreetype.so.6 jreout/lib/${TARGET_JDK}/libfreetype.so || echo "Move exit $?"
mv jreout/lib/${TARGET_JDK}/libfreetype.dylib.6 jreout/lib/${TARGET_JDK}/libfreetype.dylib || echo "Move exit $?"

# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep
# find jreout -name "*.debuginfo" | xargs -- rm
# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep jreout/lib/${TARGET_JDK}/libfontmanager.diz

find jdkout -name "*.debuginfo" | xargs -- rm
find jreout -name "*.debuginfo" -exec mv {}   dizout/ \;
