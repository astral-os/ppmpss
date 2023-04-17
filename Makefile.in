# vim: ts=8 sw=8 noet cc=80
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Portable package manager made in POSIX shell script
# Copyright (C) 2023 astral
# 
# This file is part of ppmpss.
# 
# ppmpss is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
# 
# ppmpss is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
# 
# You should have received a copy of the GNU General Public License along with
# ppmpss. If not, see <https://www.gnu.org/licenses/>.

.POSIX:

include config.mk

all: ppmpss

ppmpss:

clean:
	@rm -f ppmpss

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp ppmpss $(DESTDIR)$(PREFIX)/bin
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/ppmpss
	@mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1
	@cp ppmpss.1 $(DESTDIR)$(PREFIX)/share/man/man1
	@chmod 644 $(DESTDIR)$(PREFIX)/share/man/man1/ppmpss.1
	@cp ppmpss-pkg.1 $(DESTDIR)$(PREFIX)/share/man/man1
	@chmod 644 $(DESTDIR)$(PREFIX)/share/man/man1/ppmpss-pkg.1
	@cp ppmpss-em.1 $(DESTDIR)$(PREFIX)/share/man/man1
	@chmod 644 $(DESTDIR)$(PREFIX)/share/man/man1/ppmpss-em.1
	@cp ppmpss-rm.1 $(DESTDIR)$(PREFIX)/share/man/man1
	@chmod 644 $(DESTDIR)$(PREFIX)/share/man/man1/ppmpss-rm.1
uninstall:
	@rm -f $(DESTDIR)$(PREFIX)/bin/ppmpss
	@rm -f $(DESTDIR)$(PREFIX)/share/man/man1/ppmpss.1
	@rm -f $(DESTDIR)$(PREFIX)/share/man/man1/ppmpss-pkg.1
	@rm -f $(DESTDIR)$(PREFIX)/share/man/man1/ppmpss-em.1
	@rm -f $(DESTDIR)$(PREFIX)/share/man/man1/ppmpss-rm.1
