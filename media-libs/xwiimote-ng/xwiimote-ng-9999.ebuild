# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dev-0x7C6/xwiimote-ng.git"
inherit cmake git-r3

DESCRIPTION="Nintendo Wii Remote Linux Device Driver Tools"
HOMEPAGE="https://github.com/dev-0x7C6/xwiimote-ng"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="sys-libs/ncurses:0=
	virtual/udev"

DEPEND="${RDEPEND}"

