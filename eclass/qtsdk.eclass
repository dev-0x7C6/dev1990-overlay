# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: dev
# Purpose: Managment of Qt sdk 
#

EXPORT_FUNCTIONS src_configure src_install

IUSE="$IUSE \
	build-examples \
	+declarative \
	+doc \
	+graphicaleffects \
	+quick \
	+quick2 \
	+serialport \
	connectivity \
	enginio \
	location \
	multimedia \
	script \
	sensors \
	serialbus \
	svg \
	wayland \
	webchannel \
	webengine \
	webview \
"

S="${WORKDIR}/qt-everywhere-opensource-src-${PV}"

qtsdk_src_configure() {
	local conf=()
	use declarative || conf+=('-skip qtconnectivity')
	use doc || conf+=('-skip qtdoc')
	use enginio || conf+=('-skip qtenginio')
	use graphicaleffects || conf+=('-skip qtgraphicaleffects')
	use location || conf+=('-skip qtlocation')
	use multimedia || conf+=('-skip qtmultimedia')
	use quick || conf+=('-skip qtquickcontrols')
	use quick2 || conf+=('-skip qtquickcontrols2')
	use script || conf+=('-skip qtscript')
	use sensors || conf+=('-skip qtsensors')
	use serialbus || conf+=('-skip qtserialbus')
	use serialport || conf+=('-skip qtserialport')
	use svg || conf+=('-skip qtsvg')
	use wayland || conf+=('-skip qtwayland')
	use webchannel || conf+=('-skip qtwebchannel')
	use webengine || conf+=('-skip qtwebengine')
	use webview || conf+=('-skip qtwebview')
	use build-examples || conf+=('-no-compile-examples')
	./configure -prefix /opt/qtsdk/${P} -platform ${PN#*-} -opensource -confirm-license -optimized-tools ${conf[@]}

}

qtsdk_src_install() {
	INSTALL_ROOT="${D}/" emake install
}

