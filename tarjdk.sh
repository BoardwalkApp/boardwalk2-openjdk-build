#!/bin/bash
set -e
mv -f jre_override/* jreout/
cd jreout
tar cJf ../jre8-${TARGET_SHORT}-`date +%Y%m%d`-${JDK_DEBUG_LEVEL}.tar.xz .
