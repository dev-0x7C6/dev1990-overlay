# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Laser engraver toolkit"
HOMEPAGE="https://github.com/dev-0x7C6/laser-engraver"
EGIT_REPO_URI="https://github.com/dev-0x7C6/laser-engraver.git"

EGIT_SUBMODULES=( '*' 'formatter' )
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtserialport:5
"

DEPEND="${RDEPEND}"

src_configure() {
	cmake_src_configure
}
