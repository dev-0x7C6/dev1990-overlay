# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Flattened Device Tree Viewer written in Qt"
HOMEPAGE="https://github.com/dev-0x7C6/fdt-viewer"

EGIT_REPO_URI="https://github.com/dev-0x7C6/fdt-viewer.git"
EGIT_SUBMODULES=( '*' 'formatter' )
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
KEYWORDS="amd64 arm arm64 x86"
SLOT="0"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"

DEPEND="${RDEPEND}"
DOCS=( LICENSE )
