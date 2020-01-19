#!/bin/bash
set -e
hg clone http://hg.openjdk.java.net/mobile/jdk9 openjdk
cd openjdk
bash ./get_source.sh
