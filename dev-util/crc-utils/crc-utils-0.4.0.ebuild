# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="CRC-based checksum tools"
HOMEPAGE="https://github.com/dev-0x7C6/crc-utils"
SRC_URI="https://codeload.github.com/dev-0x7C6/crc-utils/tar.gz/refs/tags/v${PVR} -> ${PF}.tar.gz"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

DEPEND="
	dev-cpp/cli11
	dev-libs/libfmt
	dev-libs/spdlog
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND=""
