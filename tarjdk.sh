#!/bin/bash
set -e
cd jreout
tar cJf ../jre-${TARGET_SHORT}-`date +%Y%m%d`.tar.xz .
