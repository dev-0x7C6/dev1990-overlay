# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Raspberry Pi USB booting code"
HOMEPAGE="https://github.com/raspberrypi/usbboot"
EGIT_REPO_URI="https://github.com/raspberrypi/usbboot.git"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND="virtual/libusb:1"

src_install() {
	dosbin rpiboot
	insinto /usr/share/rpiboot
	doins -r msd
}
