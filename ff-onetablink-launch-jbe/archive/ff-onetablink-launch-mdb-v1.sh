#! /usr/bin/env bash
# fname: ff-onetablink-launch-mdb-v1.sh
# v1_20260529 converts a line:
#             https://www.youtube.com/results?search_query=salsa+hand+toss+flip | (7) salsa hand toss flip - YouTube
#             ... to ...
#             https://www.youtube.com/results?search_query=salsa+hand+toss+flip;salsa hand toss flip
# last 20260529
# ---

usage() {
	cat <<"EOF"
	Usage: convert-onetab-to-csv <filename>

EOF
}

if [ $# -ne 1 ]; then
	usage
	exit
else
	fjl=$1
	if [ ! -f "${fjl}" ]; then
		printf "%s\n\n" "[ERROR] No such file: ${fjl}"
		exit
	fi
fi

# sed -e 's/\([^ ]\+\) | \(.*\)/\1;\2/' -e 's/([[:digit:]]\+) //' -e '/\S/!d' "${fjl}"
sed -e 's/\([^ ]\+\) | \(.*\)/\1;\2/' -e 's/([[:digit:]]\+) //' -e '/\S/!d'  -e 's/ - YouTube//' "${fjl}"
printf "\n"


