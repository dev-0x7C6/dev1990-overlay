# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vcs-snapshot cmake-multilib

DESCRIPTION="Google's microbenchmark support library for C++"
HOMEPAGE="https://github.com/google/benchmark"
SRC_URI="https://github.com/google/benchmark/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

multilib_src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DLIB_INSTALL_DIR=$(get_libdir)
	)
	cmake-utils_src_configure mycmakeargs
}

multilib_src_install_all() {
	einstalldocs
}
