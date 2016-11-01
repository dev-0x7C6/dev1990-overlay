# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: kadu.eclass
# @MAINTAINER:
# Michał "mziab" Ziąbkowski <mziab@o2.pl>
# @BLURB: Base eclass for modular Kadu ebuilds
# @DESCRIPTION:
# Base eclass for modular Kadu ebuilds

inherit base flag-o-matic cmake-utils

LICENSE="GPL-2"
SLOT="0"
RESTRICT="primaryuri"
IUSE="debug"

# @ECLASS-VARIABLE: K_PV
# @DESCRIPTION:
# Package version in the format used by Kadu tarballs.
K_PV="${PV/_p/.}"
K_PV="${K_PV/_/-}"

# @ECLASS-VARIABLE: KADU_SRC_DIR
# @DESCRIPTION:
# Upstream tarball subdirectory
case ${PV} in
	*alpha*|*beta*|*rc*) KADU_SRC_DIR="unstable" ;;
	*) KADU_SRC_DIR="stable" ;;
esac

SRC_URI="http://download.kadu.im/${KADU_SRC_DIR}/kadu-${K_PV}.tar.bz2"

# @ECLASS-VARIABLE: MOD_NAME
# @DESCRIPTION:
# Package name the kadu- prefix. Used for plugins.
MOD_NAME="${PN#*-}"

S="${WORKDIR}/kadu-${K_PV}"

if [ "${MOD_NAME}" != "core" ]; then
	S="${S}/plugins/${MOD_NAME}"
fi

# @FUNCTION: kadu_src_configure
# @DESCRIPTION:
# Calls its parent from cmake-utils with some extra parameters
kadu_src_configure() {
	# Filter compiler flags
	filter-flags -fno-rtti

	use debug && local CMAKE_BUILD_TYPE="debug"

	local mycmakeargs="${mycmakeargs} \
		-DBUILD_DESCRIPTION:STRING=Gentoo"

	cmake-utils_src_configure
}

case ${EAPI:-0} in
	2|3|4|5) EXPORT_FUNCTIONS src_configure ;;
	*) die "no support for EAPI=${EAPI}" ;;
esac
