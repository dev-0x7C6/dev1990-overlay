# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qtsdk

EXPORT_FUNCTIONS src_configure

DESCRIPTION="Complete Qt SDK for mobile application development"

KEYWORDS="~amd64 ~x86"

RDEPEND="
	${RDEPEND}
	>=dev-util/android-ndk-18
	sys-devel/clang:=
	sys-devel/gcc:=
"

DEPEND="${RDEPEND}"

RESTRICT="strip"

NDK_PLATFORMS=( 21 22 23 24 25 26 27 28 29 )

IUSE="
	${IUSE}
	+${NDK_PLATFORMS[@]/#/ndk_}
"

REQUIRED_USE="
	${REQUIRED_USE}
	^^ ( ${NDK_PLATFORMS[@]/#/ndk_} )
"

qtsdk-select-ndk() {
	for ver in ${NDK_PLATFORMS[@]}; do
		use ndk_${ver} && qtsdk_add_flag -android-ndk-platform android-${ver}
	done
}

qtsdk-android_src_configure() {

# Help from 5.13.1:
#
#  -android-sdk path .... Set Android SDK root path [$ANDROID_SDK_ROOT]
#  -android-ndk path .... Set Android NDK root path [$ANDROID_NDK_ROOT]
#  -android-ndk-platform  Set Android platform
#  -android-ndk-host .... Set Android NDK host (linux-x86, linux-x86_64, etc.)
#                         [$ANDROID_NDK_HOST]
#  -android-arch ........ Set Android architecture (armeabi, armeabi-v7a,
#                         arm64-v8a, x86, x86_64)
#  -android-toolchain-version ... Set Android toolchain version
#  -android-style-assets  Automatically extract style assets from the device at
#                         run time. This option makes the Android style behave
#                         correctly, but also makes the Android platform plugin
#                         incompatible with the LGPL2.1. [yes]

# TODO: android arch is hardcoded (armeabi-v7a)

# Qt 5.14 will introduce:
#
#  -android-abis .......  Comma separated Android abis, default is:
#                         armeabi-v7a,arm64-v8a,x86,x86_64
#  -android-style-assets  Automatically extract style assets from the device at
#                         run time. This option makes the Android style behave
#                         correctly, but also makes the Android platform plugin
#                         incompatible with the LGPL2.1. [yes]
#
# and remove:
#  -android-toolchain-version ? (gcc removal releated?)

	qtsdk_add_flag -prefix ${QTSDK_INSTALL_DIR}
	qtsdk_add_flag -platform linux-clang
	qtsdk_add_flag -xplatform android-clang
	qtsdk_add_flag -android-sdk /opt/android-sdk-update-manager
	#qtsdk_add_flag -android-ndk /opt/android-ndk
	qtsdk-select-ndk
	use amd64 && qtsdk_add_flag -android-ndk-host linux-x86_64
	use x86 && qtsdk_add_flag -android-ndk-host linux-x86
	version_is_at_least 5.14 && qtsdk_add_flag -android-abis armeabi-v7a,arm64-v8a,x86_64
	version_is_at_least 5.14 || qtsdk_add_flag -android-arch armeabi-v7a
	version_is_at_least 5.14 || qtsdk_add_flag -android-toolchain-version 4.9

	qtsdk_populate_flags

# BUG: system-zlib cannot compile with qtsdk
#  error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘OF’ ...

# Overrides

	qtsdk_add_flag -qt-zlib
	qtsdk_add_flag -qt-libjpeg
	qtsdk_add_flag -qt-libpng

# BUG: Invalid value given for boolean command line option 'xkbcommon'.

	version_is_at_least 5.12.1 || qtsdk_add_flag -no-xkbcommon

	qtsdk_add_flag -qt-freetype
	qtsdk_add_flag -skip qttranslations
	qtsdk_add_flag -no-warnings-are-errors
	qtsdk_add_flag -no-harfbuzz
	qtsdk_add_flag -no-xcb
	qtsdk_add_flag -no-pkg-config
	qtsdk_add_flag -nomake tests
	qtsdk_add_flag -nomake examples

	./configure ${QTSDK_CONFIGURE_FLAGS[@]}
}
