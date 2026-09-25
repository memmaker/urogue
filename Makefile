# UltraRogue: The Ultimate Adventure in the Dungeons of Doom
# Copyright (C) 1985, 1986, 1992, 1993, 1995 Herb Chong
# All rights reserved.
#
# See the file LICENSE.TXT for full copyright and licensing information.

#
# Makefile for urogue
#

DISTNAME=urogue1.0.7

HDRS		  = dict.h dictutil.h rogue.h
OBJS		  = armor.o \
		artifact.o \
		bag.o \
		chase.o \
		command.o \
		daemon.o \
		daemons.o \
		dict.o \
		dictutil.o \
		encumb.o \
		fight.o \
		getplay.o \
		ident.o \
		init.o \
		io.o \
		list.o \
		magic.o \
		main.o \
		maze.o \
		memory.o \
		misc.o \
		monsdata.o \
		monsters.o \
		move.o \
		newlvl.o \
		options.o \
		pack.o \
		passages.o \
		player.o \
		potions.o \
		random.o \
		rings.o \
		rip.o \
		rooms.o \
		save.o \
		scrolls.o \
		state.o \
		status.o \
		sticks.o \
		things.o \
		trader.o \
		verify.o \
		vers.o \
		weapons.o \
		wizard.o \
		rvip.o \
		mdport.o \
		xcrypt.o

PROGRAM 	  = ur

CFILES		  = armor.c \
		artifact.c \
		bag.c \
		chase.c \
		command.c \
		daemon.c \
		daemons.c \
		dict.c \
		dictutil.c \
		encumb.c \
		fight.c \
		getplay.c \
		ident.c \
		init.c \
		io.c \
		list.c \
		magic.c \
		main.c \
		maze.c \
		memory.c \
		misc.c \
		monsdata.c \
		monsters.c \
		move.c \
		newlvl.c \
		options.c \
		pack.c \
		passages.c \
		player.c \
		potions.c \
		random.c \
		rings.c \
		rip.c \
		rooms.c \
		save.c \
		scrolls.c \
		state.c \
		status.c \
		sticks.c \
		things.c \
		trader.c \
		verify.c \
		vers.c \
		weapons.c \
		wizard.c \
		rvip.c \
		mdport.c \
		xcrypt.c

MISC=           Makefile README LICENSE.TXT history.txt TODO

CC    = gcc
CFLAGS= -O3
CRLIB = -lcurses
RM    = rm -f
TAR   = tar

urogue:	$(OBJS) $(MAKEFILE)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(CRLIB) -o $@

clean:		
	rm -f $(OBJS) urogue a.out core *.map urogue.exe urogue.cat 

dist.src:
	make clean
	tar cf $(DISTNAME)-src.tar $(CFILES) $(HDRS) $(MISC)
	gzip -f $(DISTNAME)-src.tar

dist.irix:
	make clean
	make CC=cc CFLAGS="-woff 1116 -O3" urogue
	nroff -man urogue.6 | colcrt - > urogue.cat
	tar cf $(DISTNAME)-irix.tar urogue urogue.cat README LICENSE.TXT
	gzip -f $(DISTNAME)-irix.tar

dist.aix:
	make clean
	make CC=xlc CFLAGS="-qmaxmem=16768 -O3 -qstrict" urogue
	nroff -man urogue.6 | colcrt - > urogue.cat
	tar cf $(DISTNAME)-aix.tar urogue urogue.cat README LICENSE.TXT
	gzip -f $(DISTNAME)-aix.tar

dist.linux:
	make clean
	make urogue
	groff -man urogue.6 | sed -e 's/.\x08//g' > urogue.cat
	tar cf $(DISTNAME)-linux.tar urogue urogue.cat README LICENSE.TXT
	gzip -f $(DISTNAME)-linux.tar

dist.interix:
	make clean
	make urogue
	groff -P-b -P-u -man -Tascii urogue.6 > urogue.cat
	tar cf $(DISTNAME)-interix.tar urogue urogue.cat README LICENSE.TXT
	gzip -f $(DISTNAME)-interix.tar

dist.cygwin:
	make clean
	make urogue
	groff -P-c -man -Tascii urogue.6 | sed -e 's/.\x08//g' > urogue.cat
	tar cf $(DISTNAME)-cygwin.tar urogue.exe urogue.cat README LICENSE.TXT
	gzip -f $(DISTNAME)-cygwin.tar

dist.djgpp:
	make clean
	make LDFLAGS="-L$(DJDIR)/LIB" CRLIB="-lpdcurses" urogue
	groff -man -Tascii urogue.6 | sed -e 's/.\x08//g' > urogue.cat
	rm -f $(DISTNAME)-djgpp.zip
	zip $(DISTNAME)-djgpp.zip urogue.exe urogue.cat README LICENSE.TXT

# macOS/XQuartz build with the curses shim and NetHack tiles (RVIP)
XFLAGS = -O2 -g -std=gnu89 -w -Wno-implicit-function-declaration -Wno-implicit-int -Wno-return-type -Wno-int-conversion -Wno-incompatible-pointer-types -Iport -I/opt/X11/include -I/opt/X11/include/freetype2
PORTSRC = port/wcurses.c port/tiles.c port/be_x11.c
urogue-x11: $(CFILES) $(HDRS) $(PORTSRC) port/curses.h port/tilemap.h
	$(CC) $(XFLAGS) $(EXTRA) $(CFILES) $(PORTSRC) -L/opt/X11/lib -lX11 -lXft -lfontconfig -o $@
