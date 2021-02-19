#!/bin/bash
set -e
mv jre_override/lib/* jreout/lib/
cd jreout
tar cJf ../jre8-${TARGET_SHORT}-`date +%Y%m%d`-${JDK_DEBUG_LEVEL}.tar.xz .
cd ../jdkout
tar cJf ../jdk8-${TARGET_SHORT}-`date +%Y%m%d`-${JDK_DEBUG_LEVEL}.tar.xz .

