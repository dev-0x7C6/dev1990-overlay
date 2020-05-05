# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

SRC_PN="NetworkManager-sstp"
SRC_P="${SRC_PN}-${PV}"

DESCRIPTION="Client for the proprietary Microsoft Secure Socket Tunneling Protocol(SSTP)"
HOMEPAGE="https://sourceforge.net/projects/sstp-client"
SRC_URI="https://downloads.sourceforge.net/project/sstp-client/network-manager-sstp/${SRC_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-libs/dbus-glib-0.74
	>=net-misc/sstp-client-1.0.12
	>=net-misc/networkmanager-${PV}
	net-dialup/ppp:=
	x11-libs/gtk+:3
	gnome-base/gnome-keyring
	gnome-base/libgnome-keyring
	gnome-extra/nm-applet
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	dev-util/intltool
"

S="${WORKDIR}/${SRC_P}"

src_configure() {
	local PPPD_VERSION="$(echo $(best_version net-dialup/ppp) | sed -e 's:net-dialup/ppp-\(.*\):\1:' -e 's:-r.*$::')"
	econf \
		--disable-more-warnings \
		--disable-static \
		--with-dist-version=Gentoo \
		--with-pppd-plugin-dir="${EPREFIX}/usr/$(get_libdir)/pppd/${PPPD_VERSION}"
}

src_install() {
	default
	prune_libtool_files
}

