# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: dev
# Purpose: Managment of Qt sdk 
#

inherit versionator

EXPORT_FUNCTIONS src_configure src_install

IUSE="$IUSE \
	$(version_is_at_least 5.5 && echo 3d) \
	$(version_is_at_least 5.6 && echo serialbus) \
	$(version_is_at_least 5.6 && echo webview) \
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
	svg \
	wayland \
	webchannel \
	webengine \
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
	use serialport || conf+=('-skip qtserialport')
	use svg || conf+=('-skip qtsvg')
	use wayland || conf+=('-skip qtwayland')
	use webchannel || conf+=('-skip qtwebchannel')
	use webengine || conf+=('-skip qtwebengine')
	version_is_at_least 5.5 && { use 3d || conf+=('-skip qt3d'); }
	version_is_at_least 5.5 && { use 3d || conf+=('-skip qtcanvas3d'); }
	version_is_at_least 5.6 && { use serialbus || conf+=('-skip qtserialbus'); }
	version_is_at_least 5.6 && { use webview || conf+=('-skip qtwebview'); }
	./configure -nomake tests -nomake examples -prefix /opt/qtsdk/${P} -platform ${PN#*-} -opensource -confirm-license ${conf[@]}

}

qtsdk_src_install() {
	INSTALL_ROOT="${D}/" emake install
}

