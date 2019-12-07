# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Led Frame a high performance ambilight software-based solution"
HOMEPAGE="https://github.com/dev-0x7C6/led-frame"

EGIT_REPO_URI="https://github.com/dev-0x7C6/led-frame.git"
EGIT_SUBMODULES=( '*' 'formatter' )
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3.0"
KEYWORDS="amd64 x86 arm arm64"
SLOT="0"

IUSE="
	+X
	dispmanx
	rpi3
	rpi4
	tests
	benchmarks
"

REQUIRED_USE="
	rpi3? ( dispmanx )
	rpi4? ( dispmanx )
	dispmanx? ( ^^ ( rpi3 rpi4 ) )
"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtwebsockets:5
	dev-qt/qtserialport:5
	dev-qt/qtnetwork:5
	tests? ( dev-cpp/gtest )
	benchmarks? ( dev-libs/google-benchmark )
"

DEPEND="${RDEPEND}"

DOCS=( LICENSE )

src_configure() {
	local mycmakeargs=(
		-DSUPPORT_X11=$(usex X)
		-DSUPPORT_DISPMANX=$(usex dispmanx)
		-DOPTIMIZE_RPI3=$(usex rpi3)
		-DOPTIMIZE_RPI4=$(usex rpi4)
		-DTESTS=$(usex tests)
		-DBENCHMARKS=$(usex benchmarks)
	)
	cmake-utils_src_configure
}
