#!/bin/bash
set -e

# cleanup ELF stuff
unset AR AS CC CXX LD OBJCOPY RANLIB STRIP 
git clone https://github.com/termux/termux-elf-cleaner
cd termux-elf-cleaner
make CFLAGS=__ANDROID_API__=24 termux-elf-cleaner
chmod +x termux-elf-cleaner
cd ..

mv jre_override/lib/* jreout/lib/

find jreout -name "*.so" | xargs -- ./termux-elf-cleaner/termux-elf-cleaner
find jdkout -name "*.so" | xargs -- ./termux-elf-cleaner/termux-elf-cleaner

cd jreout
tar cJf ../jre8-${TARGET_SHORT}-`date +%Y%m%d`-${JDK_DEBUG_LEVEL}.tar.xz .

cd ../jdkout
tar cJf ../jdk8-${TARGET_SHORT}-`date +%Y%m%d`-${JDK_DEBUG_LEVEL}.tar.xz .

