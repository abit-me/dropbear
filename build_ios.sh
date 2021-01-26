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

ARCH="arm64"
SDK="iphoneos"

SYSROOT="$(xcrun --sdk $SDK --show-sdk-path)"
# SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk

INCLUDES=${SYSROOT}/usr/include/
LIBRARIES=${SYSROOT}/usr/lib/
FRAMEWORKS=${SYSROOT}/System/Library/Frameworks/

export CC="$(xcrun -f --sdk $SDK clang)"
export CFLAGS="-arch $ARCH --sysroot=$SYSROOT"
export LDFLAGS="-arch $ARCH --sysroot=$SYSROOT"

CC="$CC -I${INCLUDES} -F${FRAMEWORKS} ${CFLAGS} ${LDFLAGS}"

aclocal
autoconf
autoheader

./configure --host=arm-apple-darwin
make CC="$CC" PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp"
