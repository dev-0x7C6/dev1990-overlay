# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PATCHES=( "${FILESDIR}/0001-qglobal.h-added-missing-limits-header.patch" )

inherit qtsdk-desktop-gcc
