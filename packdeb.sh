#!/bin/bash
fakeroot dh_clean
fakeroot dh_testdir
fakeroot dh_testroot
fakeroot dh_installchangelogs
fakeroot dh_installdocs
#fakeroot dh_installexamples
fakeroot dh_install
fakeroot dh_installmime
#fakeroot dh_python
fakeroot dh_installman
fakeroot dh_link
fakeroot dh_compress
fakeroot dh_fixperms
#fakeroot dh_makeshlibs
fakeroot dh_installdeb
#fakeroot dh_shlibdeps
fakeroot dh_gencontrol
fakeroot dh_md5sums
fakeroot dh_builddeb
