#!/bin/bash
set -e

if [ "$TARGET_JDK" == "arm" ]; then
  export TARGET_JDK=aarch32
fi

imagespath=openjdk/build/${JVM_PLATFORM}-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}/images

rm -rf dizout jreout jdkout
mkdir dizout

cp -r $imagespath/j2re-image jreout
cp -r $imagespath/j2sdk-image jdkout

mv jdkout/lib/${TARGET_JDK}/libfreetype.so.6 jdkout/lib/${TARGET_JDK}/libfreetype.so || echo "Move exit $?"
mv jdkout/lib/${TARGET_JDK}/libfreetype.dylib.6 jdkout/lib/${TARGET_JDK}/libfreetype.dylib || echo "Move exit $?"
mv jreout/lib/${TARGET_JDK}/libfreetype.so.6 jreout/lib/${TARGET_JDK}/libfreetype.so || echo "Move exit $?"
mv jreout/lib/${TARGET_JDK}/libfreetype.dylib.6 jreout/lib/${TARGET_JDK}/libfreetype.dylib || echo "Move exit $?"

# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep
# find jreout -name "*.diz" | xargs -- rm
# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep jreout/lib/${TARGET_JDK}/libfontmanager.diz

find jreout -name "*.diz" -delete
find jdkout -name "*.diz" -exec mv {} dizout/ \;

if [ "$BUILD_IOS" == "1" ]; then
  newlibpath=/usr/lib/jvm/java-8-openjdk/lib
  for dafile in $(find j*out -name "*.dylib"); do
    install_name_tool -add_rpath $newlibpath/server -add_rpath $newlibpath/jli \
      -add_rpath $newlibpath $changecmd $dafile
    ldid -Sios-sign-entitlements.xml $dafile
  done
  ldid -Sios-sign-entitlements.xml jreout/bin/*
  ldid -Sios-sign-entitlements.xml jdkout/jre/bin/*
fi
