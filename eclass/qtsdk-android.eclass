# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# Original Author: dev
# Purpose: Managment of Qt sdk for android 
#

inherit qtsdk

EXPORT_FUNCTIONS src_configure

ANDROID_NDK_HOST="linux-x86_64"
ANDROID_NDK_GCC="4.9"
ANDROID_CLANG_TOOLCHAIN="clang7.0"
ANDROID_NDK="/opt/android-ndk"
ANDROID_SDK="/opt/android-sdk-update-manager"

DEPEND=="dev-util/android-ndk"
RDEPEND="${DEPEND}"

qtsdk-android_src_configure() {
	qtsdk_populate_flags
	./configure -prefix ${QTSDK_INSTALL_DIR} -platform linux-clang -xplatform ${QTSDK_PLATFORM} -android-ndk ${ANDROID_NDK} -android-sdk ${ANDROID_SDK} -android-ndk-host ${ANDROID_NDK_HOST} -android-toolchain-version clang7.0 -skip qttranslations -no-warnings-are-errors -no-harfbuzz -opensource -confirm-license ${QTSDK_CONFIGURE_FLAGS[@]} -no-pkg-config
}
