#! /usr/bin/env bash
# fname: ff-onetablink-launch-mdb-v2.sh
# v1_20260529 converts a line:
#             https://www.youtube.com/results?search_query=salsa+hand+toss+flip | (7) salsa hand toss flip - YouTube
#             ... to ...
#             https://www.youtube.com/results?search_query=salsa+hand+toss+flip;salsa hand toss flip
# v2_20260529 output into array
# last 20260529
# ---

# globals
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
FFCMD='/usr/bin/firefox'
FZFCMD="fzf -e --reverse --border rounded"

unset llist
declare -a llist

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

while IFS= read LINE; do
	if [ "${#LINE}" -lt 2 ]; then
		continue
	fi
	llist+=("$(echo $LINE | sed -e 's/\([^ ]\+\) | \(.*\)/\1;\2/' -e 's/([[:digit:]]\+) //' -e '/\S/!d'  -e 's/ - YouTube//')")
done < "${fjl}"

selection=$(for lnk in "${llist[@]}"; do
	echo ${lnk}
done | ${FZFCMD})

nohup ${FFCMD} "${selection%%;*}" >&/dev/null &

printf "\n"

