# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/zip-archive/zip-archive-0.1.1.8.ebuild,v 1.1 2012/04/14 10:08:24 gienah Exp $

# ebuild generated by hackport 0.2.11

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Library for creating and modifying zip archives."
HOMEPAGE="http://github.com/jgm/zip-archive"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-haskell/binary[profile?]
		>=dev-haskell/digest-0.0.0.1[profile?]
		dev-haskell/mtl[profile?]
		>=dev-haskell/utf8-string-0.3.1[profile?]
		dev-haskell/zlib[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"