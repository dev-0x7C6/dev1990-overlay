# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: dev
# Purpose: Managment of Qt sdk 
#

inherit versionator

EXPORT_FUNCTIONS src_configure src_install
export QP=${P}
export QPN=${PN}
export QPV=${PV/_/-}
export QSLOT=${QPV%-*}

QT_HTTP_DIRECTORY="official_releases/qt"
[[ $PV == *"_"* ]] && QT_HTTP_DIRECTORY="development_releases/qt"

SRC_URI="http://download.qt.io/${QT_HTTP_DIRECTORY}/${QPV%.*}/${QPV}/single/qt-everywhere-opensource-src-${QPV}.tar.xz"
version_is_at_least 5.10 && SRC_URI="http://download.qt.io/${QT_HTTP_DIRECTORY}/${QPV%.*}/${QPV}/single/qt-everywhere-src-${QPV}.tar.xz"

IUSE="$IUSE
	$(version_is_at_least 5.5 && echo 3d)
	$(version_is_at_least 5.6 && echo serialbus)
	$(version_is_at_least 5.6 && echo webview)
	$(version_is_at_least 5.7 || echo enginio)
	+declarative
	+doc
	+graphicaleffects
	+quick
	+quick2
	+serialport
	connectivity
	examples
	location
	multimedia
	script
	sensors
	svg
	tests
	tools
	wayland
	webchannel
	webengine
	icu
	systemd
"

DEPEND="
	dev-libs/double-conversion:=
	dev-libs/glib:2
	dev-libs/libpcre2[pcre16,unicode]
	sys-libs/zlib
	icu? ( dev-libs/icu:= )
	!icu? ( virtual/libiconv )
	systemd? ( sys-apps/systemd:= )
"

#export QP=${P}
#export QPN=${PN}
#export QPV=${PV/_/-}
#export QSLOT=${QPV%-*}

S="${WORKDIR}/qt-everywhere-opensource-src-${QPV}"
version_is_at_least 5.10 && S="${WORKDIR}/qt-everywhere-src-${QPV}"

export QTSDK_INSTALL_DIR="/opt/qtsdk/${QP}"
export QTSDK_PLATFORM="${QPN#*-}"

qtsdk_populate_flags() {
	QTSDK_CONFIGURE_FLAGS=()
	QTSDK_CONFIGURE_FLAGS+=('-confirm-license')
	QTSDK_CONFIGURE_FLAGS+=('-opensource')
	use declarative || QTSDK_CONFIGURE_FLAGS+=('-skip qtconnectivity')
	use doc || QTSDK_CONFIGURE_FLAGS+=('-skip qtdoc')
	version_is_at_least 5.7 || { use enginio || QTSDK_CONFIGURE_FLAGS+=('-skip qtenginio'); }
	use examples || QTSDK_CONFIGURE_FLAGS+=('-nomake examples')
	use graphicaleffects || QTSDK_CONFIGURE_FLAGS+=('-skip qtgraphicaleffects')
	use location || QTSDK_CONFIGURE_FLAGS+=('-skip qtlocation')
	use multimedia || QTSDK_CONFIGURE_FLAGS+=('-skip qtmultimedia')
	use quick || QTSDK_CONFIGURE_FLAGS+=('-skip qtquickcontrols')
	use quick2 || QTSDK_CONFIGURE_FLAGS+=('-skip qtquickcontrols2')
	use script || QTSDK_CONFIGURE_FLAGS+=('-skip qtscript')
	use sensors || QTSDK_CONFIGURE_FLAGS+=('-skip qtsensors')
	use serialport || QTSDK_CONFIGURE_FLAGS+=('-skip qtserialport')
	use svg || QTSDK_CONFIGURE_FLAGS+=('-skip qtsvg')
	use tests || QTSDK_CONFIGURE_FLAGS+=('-nomake tests')
	use tools || QTSDK_CONFIGURE_FLAGS+=('-skip qttools')
	use wayland || QTSDK_CONFIGURE_FLAGS+=('-skip qtwayland')
	use webchannel || QTSDK_CONFIGURE_FLAGS+=('-skip qtwebchannel')
	use webengine || QTSDK_CONFIGURE_FLAGS+=('-skip qtwebengine')
	version_is_at_least 5.5 && { use 3d || QTSDK_CONFIGURE_FLAGS+=('-skip qt3d'); }
	version_is_at_least 5.5 && { use 3d || QTSDK_CONFIGURE_FLAGS+=('-skip qtcanvas3d'); }
	version_is_at_least 5.6 && { use serialbus || QTSDK_CONFIGURE_FLAGS+=('-skip qtserialbus'); }
	version_is_at_least 5.6 && { use webview || QTSDK_CONFIGURE_FLAGS+=('-skip qtwebview'); }
}

qtsdk_src_configure() {	
	qtsdk_populate_flags
	./configure -prefix ${QTSDK_INSTALL_DIR} -platform ${QTSDK_PLATFORM} ${QTSDK_CONFIGURE_FLAGS[@]}
}

qtsdk_src_install() {
	INSTALL_ROOT="${D}/" emake install
}

