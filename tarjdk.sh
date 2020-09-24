#!/bin/bash
set -e
cd jreout
tar cJf ../jre9-${TARGET_SHORT}-`date +%Y%m%d`.tar.xz .
