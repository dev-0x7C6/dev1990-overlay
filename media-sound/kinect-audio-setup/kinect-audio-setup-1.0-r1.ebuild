# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Tools to enable audio input from the Microsoft Kinect sensor device"
HOMEPAGE="https://github.com/dev-0x7C6/kinect-audio-setup"
SRC_URI="https://github.com/dev-0x7C6/kinect-audio-setup/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

IUSE="+udev +firmware"

REQUIRED_USE="udev? ( firmware )"
RDEPEND="firmware? ( media-sound/kinect-audio-firmware )"

src_configure() {
	local mycmakeargs=( -DUDEV=$(usex udev) )
	cmake_src_configure
}
