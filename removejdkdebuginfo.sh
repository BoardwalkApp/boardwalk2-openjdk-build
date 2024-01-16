#!/bin/bash
set -e

if [[ "$TARGET_JDK" == "arm" ]]; then
  export TARGET_JDK=aarch32
fi

imagespath=openjdk/build/${JVM_PLATFORM}-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}/images

rm -rf dizout jreout jdkout
mkdir dizout

cp -r $imagespath/j2re-image jreout
cp -r $imagespath/j2sdk-image jdkout

if [[ "$TARGET_JDK" == "x86" ]]; then
  export TARGET_JDK=i386
fi

mv jdkout/jre/lib/${TARGET_JDK}/libfreetype.so.6 jdkout/lib/${TARGET_JDK}/libfreetype.so || echo "Move exit $?"
mv jdkout/jre/lib/libfreetype.dylib.6 jdkout/jre/lib/libfreetype.dylib || echo "Move exit $?"
mv jreout/lib/${TARGET_JDK}/libfreetype.so.6 jreout/lib/${TARGET_JDK}/libfreetype.so || echo "Move exit $?"
mv jreout/lib/libfreetype.dylib.6 jreout/lib/libfreetype.dylib || echo "Move exit $?"

# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep
# find jreout -name "*.diz" | xargs -- rm
# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep jreout/lib/${TARGET_JDK}/libfontmanager.diz

find jreout -name "*.diz" -delete
find jdkout -name "*.diz" -exec mv {} dizout/ \;

if [[ "$BUILD_IOS" == "1" ]]; then
  install_name_tool -id @rpath/libfreetype.dylib jdkout/jre/lib/libfreetype.dylib
  install_name_tool -id @rpath/libfreetype.dylib jreout/lib/libfreetype.dylib
  install_name_tool -change build_android-arm64/lib/libfreetype.dylib @rpath/libfreetype.dylib jdkout/jre/lib/libfontmanager.dylib
  install_name_tool -change build_android-arm64/lib/libfreetype.dylib @rpath/libfreetype.dylib jreout/lib/libfontmanager.dylib

  JAVA_HOME=/usr/lib/jvm/java-8-openjdk
  for dafile in $(find j*out -name "*.dylib"); do
    install_name_tool -add_rpath $JAVA_HOME/lib/server -add_rpath $JAVA_HOME/lib/jli \
      -add_rpath $JAVA_HOME/lib -add_rpath $JAVA_HOME/jre/lib/server -add_rpath $JAVA_HOME/jre/lib/jli \
      -add_rpath $JAVA_HOME/jre/lib $dafile
    ldid -Sios-sign-entitlements.xml $dafile
  done
  ldid -Sios-sign-entitlements.xml jreout/bin/*
  ldid -Sios-sign-entitlements.xml jdkout/bin/*
  ldid -Sios-sign-entitlements.xml jdkout/jre/bin/*
fi
