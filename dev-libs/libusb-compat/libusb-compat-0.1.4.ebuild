# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb-compat/libusb-compat-0.1.4.ebuild,v 1.1 2012/05/07 14:27:34 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="Userspace access to USB devices (libusb-0.1 compat wrapper)"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-compat}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-linux"
IUSE="debug static-libs"

RDEPEND="dev-libs/libusb:1
	!dev-libs/libusb:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${PN/-compat}-0.1-ansi.patch
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable debug debug-log)
}

src_install() {
	default

	insinto /usr/share/doc/${PF}/examples
	doins examples/*.c

	rm -f "${ED}"/usr/lib*/*.la
}