#!/bin/bash
set -e

libpath=openjdk/build/${JVM_PLATFORM}-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}/jdk/lib
newlibpath=/usr/lib/jvm/java-8-openjdk/lib

for dafile in $(find jdkout/jre/lib -name "*.dylib"); do
  for dafile2 in $(find jdkout/jre/lib -name "*.dylib" | xargs basename); do
    if [ "$dafile2" != "libjvm.dylib" ] && [ "$dafile2" != "libjsig.dylib" ]; then
      export changecmd+=" -change $PWD/$libpath/$dafile2 @rpath/$dafile2"
    fi
  done
  install_name_tool -add_rpath $newlibpath/server -add_rpath $newlibpath/jli \
    -add_rpath $newlibpath $changecmd $dafile
done

for dafile in $(find jreout -name "*.dylib"); do
  install_name_tool -add_rpath $newlibpath/server -add_rpath $newlibpath/jli \
    -add_rpath $newlibpath $changecmd $dafile
done

echo $changecmd
