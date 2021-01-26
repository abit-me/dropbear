build_ios.sh ref to https://github.com/Comsecuris/ios_dropbear/blob/master/build.sh

1.download dropbear sourcecode from https://github.com/mkj/dropbear/releases/tag/DROPBEAR_2020.81
2.cp build_ios.sh to dropbear-DROPBEAR_2020.81
3.cd dropbear-DROPBEAR_2020.81 and run build_ios.sh
4.cp "dbclient dropbear dropbearconvert dropbearkey scp" to deb/usr/bin/
5.run build_deb.sh
