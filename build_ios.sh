#!/bin/bash
# (C) Copyright 2017 Comsecuris UG
#
# Usage:
# 1) download jtool from http://newosxbook.com/tools/jtool.tar
#    and extract to JTOOL path or adjust below variable
# 2) run xcodebuild -showsdks and change variable SDK below to
#    iOS SDK available in xcode
# 3) adjust ARCH if needed
# 4) run build.sh and deploy jailbreak
# 5) run dropbear -R -E -m -F -S PATHTOSHELLBINARY
# Attention: This version of dropbear enables root logins with any
# password. If you'd like to change this, change svr-authpasswd.c

JTOOL="/usr/bin/jtool"
ARCH="arm64"
SDK="iphoneos11.1"

SYSROOT="$(xcrun --sdk $SDK --show-sdk-path)"
CC="$(xcrun -f --sdk $SDK clang)"
CFLAGS="-arch $ARCH --sysroot=$SYSROOT"
LDFLAGS="-arch $ARCH --sysroot=$SYSROOT"

export CC CFLAGS LDFLAGS

autoreconf -i

make distclean

./configure --host=arm-apple-darwin
make CC="$CC"

if [ ! $? -eq 0 ]; then
    echo "there was an error during compilation"
    exit 1
fi

# we need to sign the binaries
# see saurik.com/id/8
for i in dropbear dbclient dropbearconvert dropbearkey; do
    $JTOOL --sign $i
    mv out.bin $i
    $JTOOL --sig $i
done
