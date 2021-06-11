#!/bin/bash
set -e
. setdevkitpath.sh

if [ "$BUILD_IOS" != "1" ]; then

unset AR AS CC CXX LD OBJCOPY RANLIB STRIP CPPFLAGS LDFLAGS
git clone https://github.com/termux/termux-elf-cleaner || true
cd termux-elf-cleaner
make CFLAGS=__ANDROID_API__=24 termux-elf-cleaner
chmod +x termux-elf-cleaner
cd ..

findexec() { find $1 -type f -name "*" -not -name "*.o" -exec sh -c '
    case "$(head -n 1 "$1")" in
      ?ELF*) exit 0;;
      MZ*) exit 0;;
      #!*/ocamlrun*)exit0;;
    esac
exit 1
' sh {} \; -print
}

findexec jreout | xargs -- ./termux-elf-cleaner/termux-elf-cleaner
findexec jdkout | xargs -- ./termux-elf-cleaner/termux-elf-cleaner

fi

mv jre_override/lib/* jreout/lib/ || true

cd jreout
tar cJf ../jre17-${TARGET_SHORT}-`date +%Y%m%d`-${JDK_DEBUG_LEVEL}.tar.xz .

cd ../jdkout
tar cJf ../jdk17-${TARGET_SHORT}-`date +%Y%m%d`-${JDK_DEBUG_LEVEL}.tar.xz .

