# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils unpacker

DESCRIPTION="Freescale IMX Vivante GPU drivers"
HOMEPAGE=""
SRC_URI="http://91.228.197.8/distfiles/${PF}.bin"
TARGET="imx-gpu-viv-5.0.11.p4.5-hfp"

LICENSE="EULA"
SLOT="0"
KEYWORDS="arm"
IUSE="directfb +fbdev wayland X dri"
S="${WORKDIR}"

src_unpack() {
	local file=${T}/${A}
	cp ${DISTDIR}/${A} $file || die
	chmod +x $file || die
	$file --auto-accept || die
}

src_prepare() {
	local package=${WORKDIR}
	mkdir -p $package
	mv "${WORKDIR}/${TARGET}/gpu-core/etc" ${package}/ || die
	mv "${WORKDIR}/${TARGET}/gpu-core/usr" ${package}/ || die
	rm -rf ${WORKDIR}/${TARGET}

	if ! use directfb; then
		rm -rf ${package}/etc
		rm -rf ${package}/usr/lib/*dfb*
		rm -rf ${package}/usr/lib/directfb*
	fi

	if ! use wayland; then
		rm -rf ${package}/usr/lib/*wl*
	fi

	if ! use fbdev; then
		rm -rf ${package}/usr/lib/*fb*
	fi

	if ! use X; then
		rm -rf ${package}/usr/lib/*x11*
	fi

	if ! use dri; then
		rm -rf ${package}/usr/lib/dri
	fi
}

src_install() {
	cp -rf "${S}/usr" "${D}" || die "Install failed!"
}

DEPEND=""
RDEPEND="${DEPEND}"
