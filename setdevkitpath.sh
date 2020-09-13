# Override GitHub Actions env vars

# if [[ -z "$NDK_HOME" ]]; then
  export NDK_HOME=`pwd`/android-ndk-r10e
# fi

export NDK=$NDK_HOME
export ANDROID_DEVKIT=$NDK/generated-toolchains/android-arm64-toolchain
export TOOLCHAIN=$ANDROID_DEVKIT
export TARGET=aarch64-linux-android

export CPPFLAGS="-I$NDK/platforms/android-21/arch-arm64/usr/include -I/usr/lib"
export LDFLAGS="-L$NDK/platforms/android-21/arch-arm64/usr/lib"

# Configure and build.
# Deprecated...
export AR=$TOOLCHAIN/bin/$TARGET-ar
export AS=$TOOLCHAIN/bin/$TARGET-as
export CC=$TOOLCHAIN/bin/$TARGET-gcc
export CXX=$TOOLCHAIN/bin/$TARGET-g++
export LD=$TOOLCHAIN/bin/$TARGET-ld
export RANLIB=$TOOLCHAIN/bin/$TARGET-ranlib
export STRIP=$TOOLCHAIN/bin/$TARGET-strip

# export BUILD_AR=$AR
# export BUILD_AS=$AS
# export BUILD_CC=$CC
# export BUILD_CXX=$CXX
# export BUILD_LD=$LD
# export BUILD_RANLIB=$RANLIB
# export BUILD_STRIP=$STRIP
