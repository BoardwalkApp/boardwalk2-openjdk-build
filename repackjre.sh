## Usage:
## ./repackjre.sh [path_to_normal_jre_tarballs] [output_path]

# set args
export in="$1"
export out="$2"

# set working dirs
work="$in/work"
work1="$in/work1"

# make sure paths exist
mkdir -p $work
mkdir -p $work1
mkdir -p "$out"

# here comes a not-so-complicated functions to easily make desired arch
## Usage: makearch [jre_libs_dir_name] [name_in_tarball]
makearch () { echo "Making $2..."; cd "$work"; tar xf $(find "$in" -name jre8-$2-*release.tar.xz) > /dev/null 2>&1; mv bin "$work1"/;  mkdir -p "$work1"/lib; mv lib/$1 "$work1"/lib/; mv lib/jexec "$work1"/lib/; tar cJf bin-$2.tar.xz -C "$work1" . > /dev/null 2>&1; mv bin-$2.tar.xz "$out"/; rm -rf "$work"/*; rm -rf "$work1"/*; }

# this one's static
makeuni () { echo "Making universal..."; cd "$work"; tar xf $(find "$in" -name jre8-arm64-*release.tar.xz) > /dev/null 2>&1; rm -rf bin; rm -rf lib/aarch64; rm lib/jexec; tar cJf universal.tar.xz * > /dev/null 2>&1; mv universal.tar.xz "$out"/; rm -rf "$work"/*; }

# now time to use them!
makeuni
makearch aarch32 arm
makearch aarch64 arm64
makearch i386 x86
makearch amd64 x86_64

# if running under GitHub Actions, write commit sha, else formatted system date
if [ -n "$GITHUB_SHA" ]
then
$GITHUB_SHA>$out/version
else
date +%Y%m%d>"$out/version"
fi
