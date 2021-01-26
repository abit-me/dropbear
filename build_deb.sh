#!/bin/bash
ROOT=$(cd "$(dirname "$0")";pwd)

find ${ROOT}/deb -name ".DS_Store" -depth -exec rm {} \;
dpkg-deb -Zgzip -b ${ROOT}/deb ${ROOT}/dropbear.deb
