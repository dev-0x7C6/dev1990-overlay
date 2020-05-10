# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Bitbake runtime dependencies"
HOMEPAGE="https://https://github.com/dev-0x7C6/dev1990-overlay"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	app-admin/chrpath
	dev-lang/python[sqlite]
	dev-util/diffstat
	net-libs/rpcsvc-proto
"
