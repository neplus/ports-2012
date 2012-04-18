# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hashed-storage/hashed-storage-0.5.9.ebuild,v 1.1 2012/04/14 09:02:03 gienah Exp $

# ebuild generated by hackport 0.2.13

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Hashed file storage support code."
HOMEPAGE="http://hackage.haskell.org/package/hashed-storage"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-haskell/binary[profile?]
		dev-haskell/dataenc[profile?]
		=dev-haskell/mmap-0.5*[profile?]
		dev-haskell/mtl[profile?]
		dev-haskell/zlib[profile?]
		>=dev-lang/ghc-6.12"
DEPEND=">=dev-haskell/cabal-1.6
		test? (
			dev-haskell/test-framework[profile?]
			dev-haskell/test-framework-hunit[profile?]
			dev-haskell/test-framework-quickcheck2[profile?]
			dev-haskell/zip-archive[profile?]
		)
		${RDEPEND}"

src_configure() {
	cabal_src_configure $(cabal_flag test)
}

src_install() {
	haskell-cabal_src_install

	use test && rm "${D}/usr/bin/hashed-storage-test"
}