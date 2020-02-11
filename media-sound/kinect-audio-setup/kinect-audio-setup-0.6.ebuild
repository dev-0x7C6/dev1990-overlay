# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Tools to enable audio input from the Microsoft Kinect sensor device"
HOMEPAGE="https://github.com/dev-0x7C6/kinect-audio-setup"
SRC_URI="https://github.com/dev-0x7C6/kinect-audio-setup/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
