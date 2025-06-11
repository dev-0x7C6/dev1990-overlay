# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{7..13})

inherit distutils-r1

_P=${P/-/_}
_PN=${PN/-/_}
S="${WORKDIR}/${_P}"

DISTUTILS_USE_PEP517=setuptools

DESCRIPTION="Source code formatter for cmake listfiles."
HOMEPAGE="https://github.com/cheshirekow/cmake_format.git"
SRC_URI="https://github.com/cheshirekow/cmake_format/archive/v${PV}.tar.gz -> cmake-format-v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
