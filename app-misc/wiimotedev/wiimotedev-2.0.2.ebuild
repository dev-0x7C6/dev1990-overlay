# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils versionator

DESCRIPTION="Wiimotedev Project consists of wiimotedev daemon and Qt frontend for use with Wii remotes"
HOMEPAGE="http://code.google.com/p/wiimotedev/"
SRC_URI="https://github.com/dev-0x7C6/wiimotedev/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

RDEPEND="dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtopengl:5
	net-wireless/bluez"
DEPEND="${RDEPEND}"

DOCS=( CHANGELOG README )

src_configure() {
	local mycmakeargs=(
		-DDISTRO=gentoo \
		-DUSE_STATIC_CWIID=ON \
		$(cmake-utils_use_build examples EXAMPLES)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "Please see"
	elog "http://code.google.com/p/clementine-player/wiki/WiiRemotes"
	elog "about instructions for use with media-sound/clementine"
}

