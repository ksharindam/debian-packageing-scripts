#!/bin/bash

read -p "Package Name : " PACKAGE
read -p "Version : " VERSION
read -p "Subversion : " SUB_VERSION
read -p "Architecture (any/all) : " ARCH
read -p "Description (60 Chars) : " DESCRIPTION
HOMEPAGE="https://github.com/ksharindam"
MAINTAINER="Arindam Chaudhuri"
EMAIL="ksharindam@gmail.com"

if ! [ -d "debian" ] ; then
    mkdir debian
fi
cd debian

if ! [ -d "source" ] ; then
    mkdir source
fi

cat > control <<EOF
Source: $PACKAGE
Section: utils
Priority: optional
Maintainer: $MAINTAINER <$EMAIL>
Homepage: $HOMEPAGE
Standards-Version: 3.9.8
Build-Depends: debhelper (>= 10)

Package: $PACKAGE
Architecture: $ARCH
Depends: \${shlib:Depends}, \${misc:Depends}
Description: $DESCRIPTION

EOF

cat > changelog <<EOF
$PACKAGE ($VERSION-$SUB_VERSION) stable; urgency=medium

  * New upstream release.

 -- $MAINTAINER <$EMAIL>  $(date --rfc-2822)
EOF


cat > rules << EOF
#!/usr/bin/make -f

#override_dh_auto_configure:
#	./configure --prefix=/usr/local


#override_dh_auto_install:
#	\$(MAKE) install DESTDIR=\`pwd\`/debian/$PACKAGE

EOF

cat > copyright <<EOF
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: $PACKAGE
Upstream-Contact: $EMAIL
Source: $HOMEPAGE
Comment:
 Most files in this package are licensed under the GNU General Public License.

Files: *
Copyright:
  2017, $MAINTAINER <$EMAIL>
License: GPL-3.0

EOF


cat > source/format <<EOF
3.0 (quilt)
EOF

cat > compat <<EOF
10
EOF

touch $PACKAGE.install
touch $PACKAGE.dirs
touch $PACKAGE.manpages

chmod 755 rules

# Create Desktop Menu File
read -p "Create Desktop File? (y/n) :" CREATE_DESKTOP
if [ "$CREATE_DESKTOP" = "y" ] ; then
read -p "Program Name : " PROGRAM
read -p "Program Command : " COMMAND
cat > $PACKAGE.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$PROGRAM
Icon=
Exec=$COMMAND
NoDisplay=false
Categories=Utility;Education;Game;Graphics;Network;AudioVideo;Office;System;Settings
MimeType=
StartupNotify=false
Terminal=false
EOF
fi
