#!/bin/bash
set -e

. setdevkitpath.sh

imagespath=openjdk/build/${JVM_PLATFORM}-${TARGET_JDK}-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}/images

rm -rf dizout jreout jdkout
mkdir dizout

if [ "$BUILD_IOS" == "1" ]; then
  find $imagespath -name "*.dylib" -exec ldid -Sios-sign-entitlements.xml {} \;
  for bindir in $(find $imagespath -name "bin"); do
    ldid -Sios-sign-entitlements.xml ${bindir}/*
  done
fi

cp freetype-$BUILD_FREETYPE_VERSION/build_android-$TARGET_SHORT/lib/libfreetype.so $imagespath/jdk/lib/

cp -r $imagespath/jdk jdkout

# JDK no longer create separate JRE image, so we have to create one manually.
mkdir -p jreout/bin
cp jdkout/bin/{java,jfr,keytool,rmiregistry} jreout/bin/
cp -r jdkout/{conf,legal,lib,man,release} jreout/
rm jreout/lib/src.zip

# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep
# find jreout -name "*.debuginfo" | xargs -- rm
# mv jreout/lib/${TARGET_JDK}/libfontmanager.diz.keep jreout/lib/${TARGET_JDK}/libfontmanager.diz

find jdkout -name "*.debuginfo" | xargs -- rm
find jreout -name "*.debuginfo" -exec mv {}   dizout/ \;
