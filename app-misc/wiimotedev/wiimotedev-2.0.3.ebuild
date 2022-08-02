# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Wiiremote service and input/ouput emulator"
HOMEPAGE="https://github.com/dev-0x7C6/wiimotedev"
SRC_URI="https://github.com/dev-0x7C6/wiimotedev/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="
	+daemon
	+io
	+manager
	+systemd
"

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	net-wireless/bluez
"

DEPEND="${RDEPEND}"

DOCS=( CHANGELOG README )

src_configure() {
	local mycmakeargs=(
		-DINSTALL_SYSTEMD=$(usex systemd)
		-DBUILD_DAEMON=$(usex daemon)
		-DBUILD_IO=$(usex io)
		-DBUILD_MANAGER=$(usex manager)
	)
	cmake_src_configure
}

pkg_postinst() {
	elog "Please see:"
	elog "https://github.com/clementine-player/Clementine/wiki/Wii-Remotes"
}

