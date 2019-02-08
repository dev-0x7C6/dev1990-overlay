# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit qtsdk

EXPORT_FUNCTIONS src_configure

DESCRIPTION="Complete QtSdk for mobile application development"

ANDROID_TOOLCHAIN_VERSION="4.9"
ANDROID_NDK_HOST="linux-x86_64"
ANDROID_NDK_PATH="/opt/android-ndk"
ANDROID_SDK_PATH="/opt/android-sdk-update-manager"
ANDROID_NDK_PLATFORM="android-22"
ANDROID_ARCH="armeabi-v7a"

RDEPEND="
	${RDEPEND}
	>=dev-util/android-ndk-18
	sys-devel/clang
	sys-devel/gcc
"

DEPEND="${RDEPEND}"

qtsdk-android_src_configure() {
	qtsdk_populate_flags

	# BUG: system-zlib cannot compile with qtsdk
	#  error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘OF’ ...

	qtsdk_add_flag -qt-zlib
	qtsdk_add_flag -qt-libjpeg
	qtsdk_add_flag -qt-libpng
	qtsdk_add_flag -no-xcb

	# BUG: Invalid value given for boolean command line option 'xkbcommon'.

	version_is_at_least 5.12.1 || qtsdk_add_flag -no-xkbcommon
	qtsdk_add_flag -qt-freetype
	qtsdk_add_flag -qt-harfbuzz

	./configure -prefix ${QTSDK_INSTALL_DIR} -platform linux-clang -xplatform ${QTSDK_PLATFORM} -android-ndk ${ANDROID_NDK_PATH} -android-sdk ${ANDROID_SDK_PATH} -android-ndk-host ${ANDROID_NDK_HOST} -android-toolchain-version ${ANDROID_TOOLCHAIN_VERSION} -android-ndk-platform ${ANDROID_NDK_PLATFORM} -android-arch ${ANDROID_ARCH} -skip qttranslations -no-warnings-are-errors -no-harfbuzz -opensource -confirm-license ${QTSDK_CONFIGURE_FLAGS[@]} -no-xcb -no-xkbcommon -no-pkg-config -nomake tests -nomake examples
}
