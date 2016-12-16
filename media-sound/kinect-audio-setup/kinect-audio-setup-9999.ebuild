# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Tools to enable audio input from the Microsoft Kinect sensor device"
HOMEPAGE="https://git.ao2.it/"
EGIT_REPO_URI="https://git.ao2.it/kinect-audio-setup.git"

inherit git-r3

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	DESTDIR=/usr emake
}
