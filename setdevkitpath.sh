
if [ -z "$NDK_VERSION" ]
then
  export NDK_VERSION=r18
fi

if [ -z "$JDK_DEBUG_LEVEL" ]
then
  export JDK_DEBUG_LEVEL=release
fi

if [ "$TARGET_JDK" == "aarch64" ]
then
  export TARGET_SHORT=arm64
else
  export TARGET_SHORT=$TARGET_JDK
fi

# Override GitHub Actions env var
export ANDROID_NDK_HOME=`pwd`/android-ndk-$NDK_VERSION
export NDK_HOME=$ANDROID_NDK_HOME

export API=21

export NDK=$NDK_HOME
# export ANDROID_DEVKIT=$NDK/toolchains/android-${TARGET_SHORT}-toolchain
export ANDROID_DEVKIT=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export TOOLCHAIN=$ANDROID_DEVKIT

export ANDROID_INCLUDE=$TOOLCHAIN/sysroot/usr/include

export CPPFLAGS="-I$ANDROID_INCLUDE -I$ANDROID_INCLUDE/$TARGET" # -I/usr/include -I/usr/lib
export LDFLAGS="-L$NDK/platforms/android-$API/arch-$TARGET_SHORT/usr/lib"

# Configure and build.
export AR=$TOOLCHAIN/bin/$TARGET-ar
export AS=$TOOLCHAIN/bin/$TARGET-as
export CC=$TOOLCHAIN/bin/$TARGET-gcc
export CXX=$TOOLCHAIN/bin/$TARGET-g++
export LD=$TOOLCHAIN/bin/$TARGET-ld
export RANLIB=$TOOLCHAIN/bin/$TARGET-ranlib
export STRIP=$TOOLCHAIN/bin/$TARGET-strip

