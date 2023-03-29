# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Wiimms ISO Tools is a set of command line tools to manipulate Wii and GameCube ISO images and WBFS containers."
HOMEPAGE="http://wit.wiimm.de/"

SRC_URI="https://download.wiimm.de/source/wiimms-iso-tools/wiimms-iso-tools.source-3.05a.zip"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/wiimms-iso-tools.source-3.05a"

src_compile() {
	emake DISTRIB_PATH="${D}/usr" INSTALL_PATH="${D}/usr" SHARE_PATH="${D}/usr/share"
}

