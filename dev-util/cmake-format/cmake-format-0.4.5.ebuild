# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 python3_7 )
inherit distutils-r1

_P=${P/-/_}
_PN=${PN/-/_}
S="${WORKDIR}/${_P}"

DESCRIPTION="Source code formatter for cmake listfiles."
HOMEPAGE="https://github.com/cheshirekow/cmake_format.git"
SRC_URI="mirror://pypi/${_PN:0:1}/${_PN}/${_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/pyserial"
RDEPEND="${DEPEND}"
