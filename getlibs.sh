#!/bin/sh
# https://github.com/termux/termux-packages/blob/master/disabled-packages/openjdk-9-jre-headless/build.sh
set -e
wget https://download.savannah.gnu.org/releases/freetype/freetype-2.10.0.tar.bz2
tar xf freetype-2.10.0.tar.bz2
wget https://github.com/apple/cups/releases/download/v2.2.4/cups-2.2.4-source.tar.gz
tar xf cups-2.2.4-source.tar.gz
