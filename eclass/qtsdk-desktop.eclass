# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qtsdk

EXPORT_FUNCTIONS src_configure

DESCRIPTION="Complete Qt SDK for desktop application development"

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

version_is_at_least 5.14 || { version_is_at_least 5.12 && QPA_PLATFORMS+=('mirclient'); }
version_is_at_least 5.14 || { version_is_at_least 5.12 && QPA_PLATFORMS_DISABLED+=('mirclient'); }

IUSE+=" ${QPA_PLATFORMS_ENABLED[@]/#/+qpa_}"
IUSE+=" ${QPA_PLATFORMS_DISABLED[@]/#/qpa_}"

RDEPEND="
	${RDEPEND}
	qpa_xcb? ( x11-libs/libxcb:= )
"

DEPEND="${RDEPEND}"

qtsdk-desktop_src_configure() {
	qtsdk_populate_flags
	qtsdk_mark_flag fontconfig

	# BUG: system-zlib cannot compile with qtsdk
	#  error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘OF’ ...

	qtsdk_add_flag -qt-zlib
	qtsdk_add_flag -system-libjpeg
	qtsdk_add_flag -system-libpng
	qtsdk_add_flag -system-xcb

	# BUG: Invalid value given for boolean command line option 'xkbcommon'.

	version_is_at_least 5.12.1 || qtsdk_add_flag -system-xkbcommon
	version_is_at_least 5.12.1 && qtsdk_add_flag -xkbcommon
	qtsdk_add_flag -system-freetype
	qtsdk_add_flag -system-harfbuzz

	./configure -prefix ${QTSDK_INSTALL_DIR} -platform ${QTSDK_PLATFORM} ${QTSDK_CONFIGURE_FLAGS[@]}
}
