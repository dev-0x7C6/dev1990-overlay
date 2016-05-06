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
SRC_URI="http://download.qt.io/official_releases/qt/5.6/${PV}/single/qt-everywhere-opensource-src-${PV}.tar.xz"

LICENSE="LGPL-3"
SLOT="${PV}"
KEYWORDS="x86 amd64"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-fix-ndk11.patch"
}
