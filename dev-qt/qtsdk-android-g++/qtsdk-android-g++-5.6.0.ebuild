# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

unset CXXFLAGS
unset CFLAGS
unset LDFLAGS

inherit qtsdk-android

DESCRIPTION="Qt 5 developer bundle for GCC"
HOMEPAGE=""
SRC_URI="http://download.qt.io/official_releases/qt/5.6/${QPV}/single/qt-everywhere-opensource-src-${QPV}.tar.xz"

LICENSE="LGPL-3"
SLOT="${QPV}"
KEYWORDS="x86 amd64"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	version_is_at_least 5.7 || { epatch ${FILESDIR}/${QPN}-fix-ndk11.patch; }
}
