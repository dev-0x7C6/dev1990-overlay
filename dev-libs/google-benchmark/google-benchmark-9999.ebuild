# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit git-2 cmake-utils flag-o-matic

EGIT_REPO_URI="https://github.com/google/benchmark.git"
EGIT_BRANCH="master"

DESCRIPTION="A microbenchmark support library"
HOMEPAGE="https://github.com/google/benchmark"

LICENSE="Apache-2.0"

SLOT="0"

IUSE=""

RDEPEND="
	dev-util/cmake"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

KEYWORDS="~amd64"

src_configure()
{
	append-cxxflags -std=c++11 -Wno-deprecated-declarations
	cmake-utils_src_configure

}
