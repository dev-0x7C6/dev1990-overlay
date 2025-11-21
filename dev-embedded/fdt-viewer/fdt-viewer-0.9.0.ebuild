# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Flattened Device Tree Viewer written in Qt"
HOMEPAGE="https://github.com/dev-0x7C6/fdt-viewer"

EGIT_REPO_URI="https://github.com/dev-0x7C6/fdt-viewer.git"
EGIT_SUBMODULES=( '*' 'formatter' )
EGIT_BRANCH="dev"
EGIT_COMMIT="baebd4f656a3835e1b21daa1e6d353edd03c0471"

LICENSE="GPL-3"
KEYWORDS="amd64 arm arm64 x86"
SLOT="0"

DEPEND="
	dev-qt/qtbase:6[widgets]
	x11-libs/qscintilla
"

RDEPEND="${DEPEND}"
DOCS=( LICENSE )
