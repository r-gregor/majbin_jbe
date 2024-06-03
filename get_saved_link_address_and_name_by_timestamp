#! /usr/bin/env bash
# get_saved_link_address_and_name_by_timestamp.sh
# 20240531_en

if [ $# -ne 1 ]; then
	echo "  Usage: cli command | <get_saved_link_address_and_name_by_timestamp.sh> <datestamp>"
	echo "		- cli command: cat, or any file stream display command"
	echo "		- datestamp in format: yyyymmdd"
	echo "  "
	exit
else
	dtsmmp=$1
fi

grep ${dtsmmp} | sed 's/.*<A HREF="\(https.*\)" ADD.*>\(.*\)<\/A>$/\2\n[\1]\n---/'
# grep ${dtsmmp} | sed 's/.*<A HREF="\(https.*\)" ADD_DATE="\(.*\)" LAST.*>\(.*\)<\/A>$/\3\n\2\n[\1]\n---/'
# grep ${dtsmmp} | sed 's/.*<A HREF="\(https.*\)" ADD_DATE="\(.*\)" LAST.*>\(.*\)<\/A>$/\3\n$(date -d @\2 +%y%m%d)\n[\1]\n---/'

# $> date -d @1600847942 +%Y%m%d
# 20200923

