# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit golang-build golang-vcs-snapshot user readme.gentoo-r1 systemd tmpfiles user

EGO_PN="gitlab.com/gitlab-org/gitlab-runner"

DESCRIPTION="GitLab Runner"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-runner"
SRC_URI="https://${EGO_PN}/repository/v${PV}/archive.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

RDEPEND="acct-user/gitlab-runner"
DEPEND="${RDEPEND}"

RESTRICT="mirror strip"

DOC_CONTENTS="Register the runner as root using\\n
\\t# gitlab-runner register\\n
Configure the runner in /etc/gitlab-runner/config.toml"

src_unpack() {
	golang-vcs-snapshot_src_unpack
}

src_install() {
	einstalldocs

	exeinto /usr/libexec/gitlab-runner
	doexe gitlab-runner
	dosym ../libexec/gitlab-runner/gitlab-runner /usr/bin/gitlab-runner

	newconfd "${FILESDIR}"/gitlab-runner.confd gitlab-runner
	newinitd "${FILESDIR}"/gitlab-runner.initd gitlab-runner
	systemd_dounit "${FILESDIR}"/gitlab-runner.service
	readme.gentoo_create_doc

	insopts -oroot -ggitlab-runner -m0640
	diropts -oroot -ggitlab-runner -m0750
	insinto /etc/gitlab-runner
	keepdir /etc/gitlab-runner /var/lib/gitlab-runner

	doins "${S}/src/${EGO_PN}/config.toml.example"
}

pkg_postinst() {
	tmpfiles_process gitlab-runner.conf
	readme.gentoo_print_elog
}
