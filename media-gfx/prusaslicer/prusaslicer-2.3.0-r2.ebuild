# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
WX_GTK_VER="3.0-gtk3"

inherit cmake desktop wxwidgets xdg-utils

PVE=${PV/_/-}

DESCRIPTION="A mesh slicer to generate G-code for fused-filament-fabrication (3D printers)"
HOMEPAGE="https://github.com/prusa3d/PrusaSlicer"
SRC_URI="https://github.com/prusa3d/PrusaSlicer/archive/version_${PVE}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3 CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="!media-gfx/slic3r
	>=dev-libs/boost-1.73[threads]
	>=media-gfx/openvdb-5.0.0
	>=sci-mathematics/cgal-4.14
	dev-cpp/eigen
	dev-cpp/tbb
	dev-libs/cereal
	dev-libs/expat
	dev-libs/openssl
	media-libs/glew
	net-misc/curl
	sci-libs/nlopt[cxx]
	x11-libs/wxGTK:${WX_GTK_VER}[X]
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/PrusaSlicer-version_${PVE}"

src_prepare() {
	sed -i -e 's:+UNKNOWN:+gentoo:g' ${S}/version.inc
	setup-wxwidgets
	cmake_src_prepare
}

src_configure() {
	CMAKE_BUILD_TYPE=Release

	local mycmakeargs=(
		-DSLIC3R_WX_STABLE=1
		-DSLIC3R_GUI=1
		-DSLIC3R_FHS=1
		-DSLIC3R_STATIC=0
		-DSLIC3R_GTK=3
		-DSLIC3R_PERL_XS=0
		-DSLIC3R_BUILD_SANDBOXES=0
		-DSLIC3R_BUILD_TESTS=0
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	doicon resources/icons/PrusaSlicer.png || die
	domenu "${FILESDIR}/PrusaGcodeviewer.desktop" || die
	domenu "${FILESDIR}/PrusaSlicer.desktop" || die
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
