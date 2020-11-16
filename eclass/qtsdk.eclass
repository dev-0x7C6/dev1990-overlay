# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit check-reqs

CHECKREQS_DISK_BUILD="16G"

EXPORT_FUNCTIONS src_configure src_install
export QP=${P}
export QPN=${PN}
export QPV=${PV/_/-}
export QSLOT=${QPV%-*}

LICENSE="LGPL-3"
HOMEPAGE="https://github.com/dev-0x7C6/dev1990-overlay"

SLOT="${QSLOT}"

if [[ $PV == *"_"* ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	QT_HTTP_DIRECTORY="development_releases/qt"
else
	KEYWORDS="amd64 arm arm64 x86"
	QT_HTTP_DIRECTORY="archive/qt/"
fi

# @FUNCTION: version_is_at_least
# @USAGE: [version]
version_is_at_least() {
	ver_test "${PV}" -ge "${1}" && return 0 || return 1
}

SRC_URI="http://download.qt.io/${QT_HTTP_DIRECTORY}/${QPV%.*}/${QPV}/single/qt-everywhere-opensource-src-${QPV}.tar.xz"
version_is_at_least 5.10 && SRC_URI="http://download.qt.io/${QT_HTTP_DIRECTORY}/${QPV%.*}/${QPV}/single/qt-everywhere-src-${QPV}.tar.xz"

include_use_at_least() {
	version_is_at_least ${1} && IUSE="${IUSE} ${2}"
}

include_use_deprecate_after() {
	version_is_at_least ${1} || IUSE="${IUSE} ${2}"
}

CXX_STANDARDS=( detect 11 14 17 2a )

include_use_at_least 5.5 3d
include_use_at_least 5.6 serialbus
include_use_at_least 5.6 webview
include_use_at_least 5.7 +gamepad
include_use_at_least 5.14 quick3d
include_use_deprecate_after 5.13 xmlpatterns

IUSE="
	${IUSE}
	+${CXX_STANDARDS[@]/#/cxx_}
	+declarative
	+doc
	+fontconfig
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

REQUIRED_USE="
	^^ ( ${CXX_STANDARDS[@]/#/cxx_} )
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

qtsdk_skip_before_version() {
	version_is_at_least ${1} || qtsdk_skip ${2} ${3}
}


qtsdk_skip_deprecated_after() {
	version_is_at_least ${1} && QTSDK_CONFIGURE_FLAGS+=("-skip ${3}") || qtsdk_skip ${2} ${3}
}

qtsdk_nomake() {
	local use_flag=${1}
	local module=${2:-$use_flag}
	use $use_flag || QTSDK_CONFIGURE_FLAGS+=("-nomake ${module}")
}

qtsdk_add_flag() {
	for arg; do QTSDK_CONFIGURE_FLAGS+=("${arg}"); done
}

qtsdk_populate_flags() {
	qtsdk_add_flag -confirm-license
	qtsdk_add_flag -opensource

	[[ ${QPN#*-} == *"-dbg" ]] && qtsdk_add_flag -debug
	version_is_at_least 5.9 && [[ ${QPN#*-} == *"-dbg" ]] && qtsdk_add_flag -no-optimize-debug

	qtsdk_nomake examples
	qtsdk_nomake tests

	for platform in "${QPA_PLATFORMS[@]}"; do
		qtsdk_mark_flag "qpa_${platform}" "${platform}"
	done

	for standard in ${CXX_STANDARDS[@]}; do
		use cxx_detect && continue
		use cxx_${standard} && qtsdk_add_flag -c++std c++${standard}
	done

	qtsdk_skip declarative qtconnectivity
	qtsdk_skip doc qtdoc
	qtsdk_skip graphicaleffects qtgraphicaleffects
	qtsdk_skip location qtlocation
	qtsdk_skip multimedia qtmultimedia
	qtsdk_skip quick qtquickcontrols
	qtsdk_skip quick2 qtquickcontrols2
	qtsdk_skip_before_version 6.0 script qtscript
	qtsdk_skip sensors qtsensors
	qtsdk_skip serialport qtserialport
	qtsdk_skip svg qtsvg
	qtsdk_skip tools qttools
	qtsdk_skip wayland qtwayland
	qtsdk_skip webchannel qtwebchannel
	qtsdk_skip webengine qtwebengine
	qtsdk_skip_deprecated_after 5.13 xmlpatterns qtxmlpatterns
	qtsdk_skip_at_least_in 5.14 quick3d qtquick3d
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
