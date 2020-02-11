# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Extracted firmware for Microsoft Kinnect from SDK. Should be used under terms of Kinnect SDK terms."
HOMEPAGE="https://github.com/dev-0x7C6/kinect-audio-firmware"
SRC_URI="https://github.com/dev-0x7C6/kinect-audio-firmware/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EULA"
SLOT="0"
KEYWORDS="x86 amd64"
