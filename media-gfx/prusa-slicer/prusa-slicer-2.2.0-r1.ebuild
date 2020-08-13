# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils cmake-utils

PVE=${PV/_/-}

DESCRIPTION="G-code generator for 3D printers (RepRap, Makerbot, Ultimaker etc.)"
HOMEPAGE="https://github.com/prusa3d/PrusaSlicer"
SRC_URI="https://github.com/prusa3d/PrusaSlicer/archive/version_${PVE}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3 CC-BY-3.0"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="!media-gfx/slic3r
	>=dev-libs/boost-1.55[threads]
	>=media-gfx/openvdb-5.0[-abi4-compat]
	>=sci-mathematics/cgal-4.14
	dev-cpp/eigen
	dev-cpp/tbb
	dev-libs/cereal
	dev-libs/expat
	dev-libs/openssl
	media-libs/glew
	net-misc/curl
	sci-libs/nlopt[cxx]
	x11-libs/wxGTK:3.0-gtk3
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/PrusaSlicer-version_${PVE}"

src_configure() {
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
	cmake-utils_src_configure
}

PATCHES=(
	"${FILESDIR}/0001-Raised-cmake-minimal-version-policy-update-for-GLVND.patch"
)

src_install() {
	cmake-utils_src_install

	make_desktop_entry prusa-slicer \
		"PrusaSlicer"\
		"/usr/share/PrusaSlicer/icons/PrusaSlicer_192px.png" \
		"Graphics;3DGraphics;Engineering;Development"
}
