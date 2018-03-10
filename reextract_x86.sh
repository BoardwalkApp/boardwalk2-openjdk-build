#!/bin/bash
set -e
mkdir x86tmp || true
cd x86tmp
tar xf ../freetype-2.6.2.tar.bz2
mv freetype-2.6.2 ../freetype-2.6.2-x86
cd ..
rmdir x86tmp
