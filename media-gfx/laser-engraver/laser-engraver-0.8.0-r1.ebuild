# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Laser engraver toolkit"
HOMEPAGE="https://github.com/dev-0x7C6/laser-engraver"
EGIT_REPO_URI="https://github.com/dev-0x7C6/laser-engraver.git"

EGIT_SUBMODULES=( '*' 'formatter' )
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"

IUSE="
	test
	benchmark
"

RDEPEND="
	dev-qt/qtbase:6[widgets]
	dev-qt/qtserialport:6
	test? ( dev-cpp/gtest )
	benchmark? ( dev-libs/google-benchmark )

"

DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DTESTS=$(usex test)
		-DBENCHMARKS=$(usex benchmark)
	)

	cmake_src_configure
}
