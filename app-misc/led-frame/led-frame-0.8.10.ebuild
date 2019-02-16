# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Abientled for your monitor"
HOMEPAGE="https://github.com/dev-0x7C6/led-frame"
SRC_URI="https://github.com/dev-0x7C6/led-frame/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="
	+X
	(rpi)
	(rpi3)
	tests
	benchmarks
"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtwebsockets:5
	dev-qt/qtserialport:5
	dev-qt/qtnetwork:5
"

DEPEND="${RDEPEND}"

DOCS=( CHANGELOG README )

src_configure() {
	local mycmakeargs=(
		-DSUPPORT_X11=$(usex X)
		-DSUPPORT_RPI=0
		-DSUPPORT_RPI3=0
		-DTESTS=$(usex tests)
		-DBENCHMARKS=$(usex benchmarks)
	)
	cmake-utils_src_configure
}
