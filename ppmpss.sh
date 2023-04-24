#!/bin/sh

# vim: ts=8 sw=8 noet cc=80

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

# Store name of program as script will shift and $0 can't be relied on
PROG=$(basename "$0")

# Exit codes
{
	EXIT_USAGE=1
}

# Colors
#
# Non-used colors is okay
# shellcheck disable=SC2034
{
	BLACK=30
	RED=31
	GREEN=32
	YELLOW=33
	BLUE=34
	PURPLE=35
	CYAN=36
	WHITE=37
}

# Print a message from ppmpss
#
# usage:
# msgf <COLOR> [fmt]
#
# example:
# msgf $BLUE "Hello, world\n"
# msgf >&2 $RED "Error\n"
#
# Expansion of variables inside printf is desired
# shellcheck disable=SC2059
msgf() {
	printf "\033[1m=>\033[%smppmpss\033[0m: " "$1"
	shift
	printf "$@"
}

# Function to run when INT signal is received
#
# interrupt is never called except for SIGINT trap
# shellcheck disable=SC2317,SC2086
interrupt() {
	echo
	msgf >&2 $RED "SIGINT received...\n"
	kill -9 $$
}

trap 'interrupt' INT

# Check if no command is specified
if [ $# -eq 0 ]
then
	msgf >&2 $RED "usage: %s <command> ...\n" "$PROG"
	exit $EXIT_USAGE
fi

# Process different commands
case $1 in
pkg)
	shift

	output=
	template=
	while getopts o:c: name
	do
		case $name in
		o)
			output=$OPTARG
			;;
		c)
			template=$OPTARG
			;;
		?)
			msgf >&2 $RED "usage: %s [-o <OUTPUT>] [-c <TEMPLATE>] [pkg]...\n" "$PROG"
			exit $EXIT_USAGE
			;;
		esac
	done
	shift $((OPTIND-1))

	if [ "$output" ]
	then
		msgf $BLUE "specified output: %s\n" "$output"
	fi

	if [ "$template" ]
	then
		msgf $BLUE "specified template: %s\n" "$template"
	fi

	msgf $PURPLE "specified packages: %s\n" "$*"
	;;
em)
	shift

	sflag=
	uflag=
	repo=
	while getopts suR: name
	do
		case $name in
		s)
			sflag=1
			;;
		u)
			uflag=1
			;;
		R)
			repo=$OPTARG
			;;
		?)
			msgf >&2 $RED "usage: %s [-s] [-u] [-R <repo>] [pkg]...\n" "$PROG"
			exit $EXIT_USAGE
			;;
		esac
	done
	shift $((OPTIND-1))

	if [ "$sflag" ]
	then
		msgf $BLUE "sync flag specified\n"
	fi

	if [ "$uflag" ]
	then
		if [ $# -eq 0 ]
		then
			msgf $BLUE "system update specified\n"
		fi
		msgf $BLUE "update flag specified\n"
	fi

	if [ "$repo" ]
	then
		msgf $BLUE "specified repo: %s\n" "$repo"
	fi

	msgf $PURPLE "specified packages: %s\n" "$*"
	;;
rm)
	shift

	msgf $PURPLE "specified packages: %s\n" "$*"
	;;
chroot)
	shift

	if [ $# -ne 1 ]
	then
		msgf >&2 $RED "usage: %s chroot <dir>\n" "$PROG"
		exit $EXIT_USAGE
	fi

	msgf $PURPLE "specified chroot: %s\n" "$1"
	;;
*)
	msgf >&2 $RED "unknown command: %s\n" "$1"
	exit $EXIT_USAGE
	;;
esac

exit 0
