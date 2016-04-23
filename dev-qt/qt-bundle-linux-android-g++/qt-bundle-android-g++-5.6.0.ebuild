# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Qt 5 developer bundle for GCC"
HOMEPAGE=""
SRC_URI="http://download.qt.io/official_releases/qt/5.6/${PV}/single/qt-everywhere-opensource-src-${PV}.tar.xz"

LICENSE="LGPL-3"
SLOT="${PV}"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/qt-everywhere-opensource-src-$PV"

src_configure() {
	./configure -prefix /opt/qt/$PV-${PN#qt-bundle-*} -xplatform ${PV#qt-bundle-*} -nomake tests -nomake examples -android-ndk /opt/android-ndk -android-sdk /opt/android-sdk-update-manager -android-ndk-host linux-x86_64 -android-toolchain-version 4.9 -skip qttranslations -no-warnings-are-errors -no-harfbuzz
}
