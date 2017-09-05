# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Wiimms ISO Tools is a set of command line tools to manipulate Wii and GameCube ISO images and WBFS containers."
HOMEPAGE="http://wit.wiimm.de/"

inherit subversion

ESVN_REPO_URI="http://opensvn.wiimm.de/wii/trunk/wiimms-iso-tools/"
ESVN_PROJECT="wiimms-iso-tools"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

#src_compile() {
#	export INSTALL_PATH=/usr
#	emake
#}

src_configure() {
	./setup.sh
}

#src_configure() {
#	econf --prefix=/usr
#}
