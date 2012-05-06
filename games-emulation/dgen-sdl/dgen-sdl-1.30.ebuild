# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dgen-sdl/dgen-sdl-1.30.ebuild,v 1.1 2012/05/02 17:21:22 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="A Linux/SDL-Port of the famous DGen MegaDrive/Genesis-Emulator"
HOMEPAGE="http://tamentis.com/projects/dgen/"
SRC_URI="mirror://sourceforge/dgen/files/${P}.tar.gz"

LICENSE="dgen-sdl as-is LGPL-2.1 GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="joystick opengl"

RDEPEND="media-libs/libsdl[joystick?]
	app-arch/libarchive
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable x86 asm) \
		$(use_enable joystick) \
		$(use_enable opengl)
}

src_compile() {
	emake -C musa m68kops.h || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README sample.dgenrc
	prepgamesdirs
}