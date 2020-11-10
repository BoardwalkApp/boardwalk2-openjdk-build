Based on http://openjdk.java.net/projects/mobile/android.html

## Building 

### Setup
- Download Android NDK r10e from https://developer.android.com/ndk/downloads/older_releases.html and place it in this directory (Can't automatically download because of EULA)
- **Warning**: Do not attempt to build use newer or older NDK, it will lead to compilation errors.

### Architecture specific environment variables
<table>
      <thead>
        <tr>
          <th></th>
          <th align="center" colspan="7">Environment variables</th>
        </tr>
        <tr>
          <th>Architectures</th>
          <th align="center">TARGET</th>
          <th align="center">TARGET_JDK</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>armv8/aarch64</td>
          <td align="center">aarch64-linux-android</td>
          <td align="center">aarch64</td>
        </tr>
        <tr>
          <td>armv7/aarch32</td>
          <td align="center">arm-linux-androideabi</td>
          <td align="center">arm</td>
        </tr>
        <tr>
          <td>x86/i686</td>
          <td align="center">i686-linux-android</td>
          <td align="center">x86</td>
        </tr>
        <tr>
          <td>x86_64/amd64</td>
          <td align="center">x86_64-linux-android</td>
          <td align="center">x86_64</td>
        </tr>
      </tbody>
	</table>

### Run in this directory:
```
export BUILD_FREETYPE_VERSION=[2.6.2/.../2.10.0] # default: 2.10.0
export JDK_DEBUG_LEVEL=[release/fastdebug/debug] # default: release
./extractndk.sh
./getlibs.sh
./maketoolchain.sh
./clonejdk.sh
./buildlibs.sh
./buildjdk.sh
./removejdkdebuginfo.sh
./tarjdk.sh
```

