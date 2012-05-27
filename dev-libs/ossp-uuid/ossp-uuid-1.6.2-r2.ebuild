# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ossp-uuid/ossp-uuid-1.6.2-r2.ebuild,v 1.1 2012/05/24 20:07:50 dev-zero Exp $

EAPI="4"

PHP_EXT_NAME="uuid"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
USE_PHP="php5-3 php5-4"

MY_P="uuid-${PV}"
PHP_EXT_S="${WORKDIR}/${MY_P}/php"
PHP_EXT_OPTIONAL_USE="php"

inherit eutils multilib php-ext-source-r2

DESCRIPTION="An ISO-C:1999 API and corresponding CLI for the generation of DCE 1.1, ISO/IEC 11578:1996 and RFC 4122 compliant UUID."
HOMEPAGE="http://www.ossp.org/pkg/lib/uuid/"
SRC_URI="ftp://ftp.ossp.org/pkg/lib/uuid/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="+cxx perl php static-libs"

DEPEND="perl? ( dev-lang/perl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {

	epatch \
		"${FILESDIR}/${P}-gentoo-r1.patch" \
		"${FILESDIR}/${P}-gentoo-perl.patch"

	if use php; then
		local slot
		for slot in $(php_get_slots); do
	        php_init_slot_env ${slot}
			epatch \
				"${FILESDIR}/${P}-gentoo-php.patch" \
				"${FILESDIR}/${P}-php.patch"
		done

		php-ext-source-r2_src_prepare
	fi
}

src_configure() {
	# Notes:
	# * collides with e2fstools libs and includes if not moved around
	# * pgsql-bindings need PostgreSQL-sources and are included since PostgreSQL 8.3
	econf \
		--includedir=/usr/include/ossp \
		--with-dce \
		--without-pgsql \
		--without-php \
		$(use_with cxx) \
		$(use_with perl) \
		$(use_enable static-libs static)

	if use php; then
		php-ext-source-r2_src_configure
	fi
}

src_compile() {
	default

	if use php; then
		php-ext-source-r2_src_compile
	fi
}

src_install() {
	DOCS="AUTHORS BINDINGS ChangeLog HISTORY NEWS OVERVIEW PORTING README SEEALSO THANKS TODO USERS"
	default

	if use php ; then
		php-ext-source-r2_src_install
		cd "${S}/php"
		insinto /usr/share/php
		newins uuid.php5 uuid.php
	fi

	use static-libs || rm -rf "${D}"/usr/lib*/*.la

	mv "${D}/usr/$(get_libdir)/pkgconfig"/{,ossp-}uuid.pc
	mv "${D}/usr/share/man/man3"/uuid.3{,ossp}
	mv "${D}/usr/share/man/man3"/uuid++.3{,ossp}
}

src_test() {
	export LD_LIBRARY_PATH="${S}/.libs" # required for the perl-bindings to load the (correct) library
	default
}