# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: Bartłomiej Burdukiewicz
# Purpose: Multiple Qt SDK for developers
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

#  Platform backends:
#    -directfb .......... Enable DirectFB support [no] (Unix only)
#    -eglfs ............. Enable EGLFS support [auto; no on Android and Windows]
#    -gbm ............... Enable backends for GBM [auto] (Linux only)
#    -kms ............... Enable backends for KMS [auto] (Linux only)
#    -linuxfb ........... Enable Linux Framebuffer support [auto] (Linux only)
#    -mirclient ......... Enable Mir client support [no] (Linux only)
#    -xcb ............... Select used xcb-* libraries [system/qt/no]

QPA_PLATFORMS=( directfb eglfs gbm kms linuxfb xcb )
QPA_PLATFORMS_ENABLED+=( eglfs gbm kms xcb )
QPA_PLATFORMS_DISABLED+=( directfb linuxfb )

version_is_at_least 5.12 && QPA_PLATFORMS+=('mirclient')
version_is_at_least 5.12 && QPA_PLATFORMS_DISABLED+=('mirclient')

IUSE+=" ${QPA_PLATFORMS_ENABLED[@]/#/+qpa_platform_}"
IUSE+=" ${QPA_PLATFORMS_DISABLED[@]/#/qpa_platform_}"

include_use_at_least() {
	version_is_at_least ${1} && IUSE="${IUSE} ${2}"
}

include_use_at_least 5.5 3d
include_use_at_least 5.6 serialbus
include_use_at_least 5.6 webview
include_use_at_least 5.7 +gamepad

IUSE="
	${IUSE}
	+declarative
	+doc
	+fontconfig
	+gamepad
	+graphicaleffects
	+icu
	+multimedia
	+quick
	+quick2
	+serialport
	+tools
	connectivity
	examples
	location
	script
	sensors
	svg
	systemd
	tests
	wayland
	webchannel
	webengine
"

RDEPEND="
	dev-libs/double-conversion:=
	dev-libs/glib:2
	media-libs/fontconfig
	>=media-libs/freetype-2.6.1:2
	>=media-libs/harfbuzz-1.6.0:=
	dev-libs/libpcre2[pcre16,unicode]
	media-libs/libpng:0=
	sys-libs/zlib
	fontconfig? ( media-libs/fontconfig )
	qpa_platform_xcb? ( x11-libs/libxcb:= )
	icu? ( dev-libs/icu:= )
	!icu? ( virtual/libiconv )
	systemd? ( sys-apps/systemd:= )
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/qt-everywhere-opensource-src-${QPV}"
version_is_at_least 5.10 && S="${WORKDIR}/qt-everywhere-src-${QPV}"

export QTSDK_INSTALL_DIR="/opt/qtsdk/${QP}"
export QTSDK_PLATFORM="${QPN#*-}"
QTSDK_PLATFORM="${QTSDK_PLATFORM%*-dbg}"

qtsdk_mark_flag() {
	local use_flag=${1}
	local cfg_flag=${2:-$use_flag}
	use $use_flag && QTSDK_CONFIGURE_FLAGS+=("-${cfg_flag}")
	use $use_flag || QTSDK_CONFIGURE_FLAGS+=("-no-${cfg_flag}")
}

qtsdk_skip() {
	local use_flag=${1}
	local module=${2:-$use_flag}
	use $use_flag || QTSDK_CONFIGURE_FLAGS+=("-skip ${module}")
}

qtsdk_skip_at_least_in() {
	version_is_at_least ${1} && qtsdk_skip ${2} ${3}
}

qtsdk_nomake() {
	local use_flag=${1}
	local module=${2:-$use_flag}
	use $use_flag || QTSDK_CONFIGURE_FLAGS+=("-nomake ${module}")
}

qtsdk_add_flag() {
	QTSDK_CONFIGURE_FLAGS+=("${1:-undefined}")
}

qtsdk_populate_flags() {
	QTSDK_CONFIGURE_FLAGS=()

	for platform in "${QPA_PLATFORMS[@]}"; do
		qtsdk_mark_flag "qpa_platform_${platform}" "${platform}"
	done

	qtsdk_mark_flag fontconfig
	qtsdk_nomake examples
	qtsdk_nomake tests

	[[ ${QPN#*-} == *"-dbg" ]] && qtsdk_add_flag -debug
	version_is_at_least 5.9 && [[ ${QPN#*-} == *"-dbg" ]] && qtsdk_add_flag -no-optimize-debug

	qtsdk_add_flag -confirm-license
	qtsdk_add_flag -opensource

	# BUG: system-zlib cannot compile with qtsdk
	#  error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘OF’ ...
	qtsdk_add_flag -qt-zlib
	qtsdk_add_flag -system-libjpeg
	qtsdk_add_flag -system-libpng
	qtsdk_add_flag -system-xcb
	# ERROR: Invalid value given for boolean command line option 'xkbcommon'.
	version_is_at_least 5.12.1 || qtsdk_add_flag -system-xkbcommon
	version_is_at_least 5.12.1 && qtsdk_add_flag -xkbcommon
	qtsdk_add_flag -system-freetype
	qtsdk_add_flag -system-harfbuzz

	qtsdk_skip declarative qtconnectivity
	qtsdk_skip doc qtdoc
	qtsdk_skip graphicaleffects qtgraphicaleffects
	qtsdk_skip location qtlocation
	qtsdk_skip multimedia qtmultimedia
	qtsdk_skip quick qtquickcontrols
	qtsdk_skip quick2 qtquickcontrols2
	qtsdk_skip script qtscript
	qtsdk_skip sensors qtsensors
	qtsdk_skip serialport qtserialport
	qtsdk_skip svg qtsvg
	qtsdk_skip tools qttools
	qtsdk_skip wayland qtwayland
	qtsdk_skip webchannel qtwebchannel
	qtsdk_skip webengine qtwebengine
	qtsdk_skip_at_least_in 5.5 3d qt3d
	qtsdk_skip_at_least_in 5.5 3d qtcanvas3d
	qtsdk_skip_at_least_in 5.6 serialbus qtserialbus
	qtsdk_skip_at_least_in 5.6 webview qtwebview
	qtsdk_skip_at_least_in 5.7 gamepad qtgamepad
}

qtsdk_src_configure() {
	qtsdk_populate_flags
	./configure -prefix ${QTSDK_INSTALL_DIR} -platform ${QTSDK_PLATFORM} ${QTSDK_CONFIGURE_FLAGS[@]}
}

qtsdk_src_install() {
	INSTALL_ROOT="${D}/" emake install
}
