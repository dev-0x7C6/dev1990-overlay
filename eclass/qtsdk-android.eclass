# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: Bartłomiej Burdukiewicz
# Purpose: Multiple Qt SDK for developers
#

inherit qtsdk

EXPORT_FUNCTIONS src_configure

ANDROID_TOOLCHAIN_VERSION="4.9"
ANDROID_NDK_HOST="linux-x86_64"
ANDROID_NDK_PATH="/opt/android-ndk"
ANDROID_SDK_PATH="/opt/android-sdk-update-manager"
ANDROID_NDK_PLATFORM="android-22"
ANDROID_ARCH="armeabi-v7a"

DEPEND="dev-util/android-ndk"
RDEPEND="${DEPEND}"

qtsdk-android_src_configure() {
	qtsdk_populate_flags
	./configure -prefix ${QTSDK_INSTALL_DIR} -platform linux-clang -xplatform ${QTSDK_PLATFORM} -android-ndk ${ANDROID_NDK_PATH} -android-sdk ${ANDROID_SDK_PATH} -android-ndk-host ${ANDROID_NDK_HOST} -android-toolchain-version ${ANDROID_TOOLCHAIN_VERSION} -android-ndk-platform ${ANDROID_NDK_PLATFORM} -android-arch ${ANDROID_ARCH} -skip qttranslations -no-warnings-are-errors -no-harfbuzz -opensource -confirm-license ${QTSDK_CONFIGURE_FLAGS[@]} -no-xcb -no-xkbcommon -no-pkg-config -nomake tests -nomake examples
}
