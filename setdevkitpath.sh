export NDK=`pwd`/android-ndk-r10e
export ANDROID_DEVKIT=$NDK/generated-toolchains/android-arm64-toolchain
export TOOLCHAIN=$NDK/generated-toolchains/android-arm64-toolchain
export TARGET=aarch64-linux-android

# Configure and build.
export AR=$TOOLCHAIN/bin/$TARGET-ar
export AS=$TOOLCHAIN/bin/$TARGET-as
export CC=$TOOLCHAIN/bin/$TARGET-gcc
export CXX=$TOOLCHAIN/bin/$TARGET-g++
export LD=$TOOLCHAIN/bin/$TARGET-ld
export RANLIB=$TOOLCHAIN/bin/$TARGET-ranlib
export STRIP=$TOOLCHAIN/bin/$TARGET-strip
