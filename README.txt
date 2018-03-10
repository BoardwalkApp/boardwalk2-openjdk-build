Based on http://openjdk.java.net/projects/mobile/android.html

Download Android NDK r10e from https://developer.android.com/ndk/downloads/older_releases.html and place it in this directory

(Can't automatically download because of EULA)

Run in this directory:

./extractndk.sh
./getlibs.sh
./maketoolchain.sh
./clonejdk.sh
./buildlibs.sh
./buildjdk.sh
./removejdkdebuginfo.sh
./tarjdk.sh

For x86:
./maketoolchain_x86.sh
./reextractlibs_x86.sh
./buildlibs_x86.sh
./buildjdk_x86.sh
