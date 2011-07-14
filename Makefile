# New ports collection makefile for:	Verlihub
# Date created:				2 April 2004
# Whom:					Bill Cadwallader <hurbold@yahoo.com>
#
# $FreeBSD: ports/net-p2p/verlihub/Makefile,v 1.30 2010/12/04 07:33:12 ade Exp $
#

PORTNAME=	verlihub
PORTVERSION=	1.0
PORTEPOCH=	1
CATEGORIES=	net-p2p
MASTER_SITES=	http://www.verlihub-project.org/ SF/${PORTNAME}/Verlihub/${PORTVERSION}

MAINTAINER=	netcelli@verlihub-project.org
COMMENT=	VerliHub is a Direct Connect protocol server (Hub)

WRKSRC=		${WRKDIR}/${PORTNAME}
LICENSE=	GPLv2

BUILD_DEPENDS=	bash:${PORTSDIR}/shells/bash \
			GeoIP:${PORTSDIR}/net/GeoIP \
			pcre:${PORTSDIR}/devel/pcre \
			mysql51-client:${PORTSDIR}/databases/mysql51-client
RUN_DEPENDS=	${BUILD_DEPENDS}

USE_RC_SUBR=	verlihub-daemon
SUB_FILES=	verlihub-daemon
SUB_LIST=	PREFIX=${PREFIX}
USE_GCC=	4.2+
USE_CMAKE=	yes
USE_LDCONFIG=	yes
USE_OPENSSL=	yes

OPTIONS=	CHATROOM "Create individual chatrooms" On \
		FORBID  "Filter messages for forbidden words" On \
		IPLOG "Save log history for IP and nicknames" On \
		ISP "Check connection, nicknames, minimum shares, etc" On\
		LUA "Load scripts written in LUA language" On \
		FLOODPROT "more control for hub flooding" On \
		MESSENGER "Sends a message to offline users" Off \
		PYTHON "Use scripts written with Python" On \
		REPLACER "Replaces given patterns in text" On \
		STATS "Periodically saves statistics in the DB" Off

.include <bsd.port.options.mk>

CMAKE_OUTSOURCE=1
.if !defined(WITHOUT_NLS)
USE_GETTEXT=	yes
.endif
.if defined(WITHOUT_CHATROOM)
CMAKE_ARGS+=	-DWITH_CHATROOM:BOOL=OFF
.endif
.if defined(WITHOUT_FORBID)
CMAKE_ARGS+=	-DWITH_FORBID:BOOL=OFF
.endif
.if defined(WITHOUT_IPLOG)
CMAKE_ARGS+=	-DWITH_IPLOG:BOOL=OFF
.endif
.if defined(WITHOUT_ISP)
CMAKE_ARGS+=	-DWITH_ISP:BOOL=OFF
.endif
.if defined(WITHOUT_FLOODPROT)
CMAKE_ARGS+=	-DWITH_FLOODPROT:BOOL=OFF
.endif
.if defined(WITHOUT_LUA)
CMAKE_ARGS+=	-DWITH_LUA:BOOL=OFF
.else
USE_LUA=	5.1
.endif
.if defined(WITHOUT_MESSENGER)
CMAKE_ARGS+=	-DWITH_MESSENGER:BOOL=OFF
.endif
.if defined(WITHOUT_PYTHON)
CMAKE_ARGS+=	-DWITH_PYTHON:BOOL=OFF
.else
USE_PYTHON=	 2.7
.endif
.if defined(WITHOUT_REPLACER)
CMAKE_ARGS+=	-DWITH_REPLACER:BOOL=OFF
.endif
.if defined(WITHOUT_STATS)
CMAKE_ARGS+=	-DWITH_STATS:BOOL=OFF
.endif

post-install:
	@${ECHO_MSG} " You are now ready to use VerliHub into your system."
	@${ECHO_MSG} " Please report all bugs to http://www.verlihub-project.org/bugs"
	@${ECHO_MSG} " "
	@${ECHO_MSG} " Now you could use deamon editing config file /etc/rc.conf."
	@${ECHO_MSG} " Check config var in init file. Then start VerliHub daemon using"
	@${ECHO_MSG} " ${PREFIX}/etc/rc.d/verlihub start"
	@${ECHO_MSG} " "
	@${ECHO_MSG} " If you need help you can read the manual at"
	@${ECHO_MSG} " http://www.verlihub-project.org/manual or ask on forum at"
	@${ECHO_MSG} " http://www.verlihub-project.org/discussions"
	@${ECHO_MSG} " "
	@${ECHO_MSG} " You need to configure verlihub before starting it."
	@${ECHO_MSG} " Use vh_manage or vh_manage_cli scripts"
	@${ECHO_MSG} " If you alread do tht please skip this step."
	@${ECHO_MSG} " "
	@${ECHO_MSG} " If you are updating verlihub from version < 1.0 you need"
	@${ECHO_MSG} " to run migration script for each of your installed hubs:"
	@${ECHO_MSG} " vh_migration_0.9.8eto1.0. Please follow the instructions"
	@${ECHO_MSG} " in the script"

.include <bsd.port.mk>
