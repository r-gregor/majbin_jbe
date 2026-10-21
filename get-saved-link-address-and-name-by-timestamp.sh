#! /usr/bin/env bash
#! /usr/bin/env bash
# fname: get-saved-link-address-and-name-by-timestamp.sh
# descpt: get saved link address and name by timestamp.sh
# 20261021 v1
# last: 20261021
# ---


if [ ! -p /dev/stdin ] || [ $# -ne 1 ]; then
	printf "[!] usage: cli command | <get_saved_link_address_and_name_by_timestamp> <datestamp>\n"
	printf "           - cli command: cat, or any file stream display command\n"
	printf "           - datestamp in format: yyyymmdd\n"
	printf "\n"
	exit
else
	dtsmmp=$1
fi

grep ${dtsmmp} | sed 's/.*<A HREF="\(https.*\)" ADD.*>\(.*\)<\/A>$/\2\n[\1]\n---/'

