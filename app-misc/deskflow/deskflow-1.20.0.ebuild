# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg-utils

CP="deskflow-${P/-r/+r}"

DESCRIPTION="Deskflow lets you share one mouse and keyboard between multiple computers"
HOMEPAGE="https://github.com/deskflow/deskflow"

#https://codeload.github.com/deskflow/deskflow/tar.gz/refs/tags/1.17.0%2Br1
SRC_URI="https://github.com/deskflow/deskflow/archive/refs/tags/v${PVR/-r/+r}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/${PF}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="gui"

RDEPEND="
	>=dev-libs/libportal-0.8.0
	dev-cpp/cli11
	dev-cpp/tomlplusplus
	dev-libs/glib
	dev-libs/libei
	dev-libs/openssl:=
	dev-libs/pugixml
	gui? ( dev-qt/qtbase:6 )
	sys-libs/glibc
	x11-libs/gdk-pixbuf
	x11-libs/libICE:=
	x11-libs/libSM:=
	x11-libs/libX11:=
	x11-libs/libXext:=
	x11-libs/libXi:=
	x11-libs/libXinerama:=
	x11-libs/libXrandr:=
	x11-libs/libXtst:=
	x11-libs/libnotify
	x11-libs/libxkbcommon
"

DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	gui? (
		dev-qt/linguist-tools:5
	)"

src_configure() {
	local mycmakeargs=(
		-DBUILD_GUI=$(usex gui)
		-DBUILD_INSTALLER=OFF
		-DBUILD_TESTS=OFF
		-DENABLE_COVERAGE=OFF
	)

	cmake_src_configure
}

src_install() {
	if use gui; then
		newicon -s 512 "${S}/deploy/linux/deskflow.png" deskflow.png
		make_desktop_entry deskflow Deskflow deskflow 'Utility;'
	fi

	einstalldocs
	cmake_src_install
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
