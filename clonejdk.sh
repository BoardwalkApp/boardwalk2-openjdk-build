#!/bin/bash
set -e
hg clone http://hg.openjdk.java.net/mobile/dev openjdk
cd openjdk
bash ./get_source.sh
