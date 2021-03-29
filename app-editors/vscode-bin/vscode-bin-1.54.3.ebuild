# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils

MY_PN="${PN/-bin}"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft (binary version)"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="https://update.code.visualstudio.com/${PV}/linux-x64/stable -> ${MY_P}-amd64.tar.gz"

RESTRICT="mirror strip bindist"

LICENSE="MS-vscode"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND="
	>=media-libs/libpng-1.2.46
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	x11-libs/libXtst
"

RDEPEND="
	${DEPEND}
	app-accessibility/at-spi2-atk
	>=net-print/cups-2.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/libsecret[crypt]"

S="${WORKDIR}/VSCode-linux-x64"

DOCS=( resources/app/LICENSE.rtf )

QA_PRESTRIPPED="*"
QA_PREBUILT="opt/${MY_PN}/code"

src_install(){
	mkdir -p "${ED%/}/opt/${MY_PN}"
	cp -r . "${ED%/}/opt/${MY_PN}/"
	dodir /usr/bin
	dosym ../../opt/${MY_PN}/bin/code /usr/bin/${MY_PN}
	dosym ../../opt/${MY_PN}/bin/code /usr/bin/code
	domenu "${FILESDIR}/${PN}.desktop"
	domenu "${FILESDIR}/${PN}-url-handler.desktop"
	newicon "resources/app/resources/linux/code.png" ${MY_PN}.png
	einstalldocs
	pax-mark m "${ED%/}"/opt/${MY_PN}/code
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
