#!/bin/bash
set -e
cd jreout
tar cJf ../jre8-${TARGET_SHORT}-`date +%Y%m%d`.tar.xz .
