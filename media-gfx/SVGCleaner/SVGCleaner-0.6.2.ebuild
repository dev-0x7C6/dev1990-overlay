# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="SVG Cleaner could help you to clean up your SVG files from unnecessary data."
HOMEPAGE="https://github.com/RazrFalcon/SVGCleaner"
SRC_URI="https://github.com/RazrFalcon/SVGCleaner/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
inherit qmake-utils
DEPEND="dev-qt/qtgui:4
        dev-qt/qtcore:4
        dev-qt/qtsvg:4"
RDEPEND="${DEPEND}
        app-arch/p7zip"

src_configure() {
        eqmake4
}

src_install() {
        emake install INSTALL_ROOT="${D}"
		exeinto /usr/bin
		doexe bin/svgcleaner-gui
		doexe bin/svgcleaner-cli
}

