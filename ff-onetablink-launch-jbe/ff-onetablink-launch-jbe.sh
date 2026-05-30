#! /usr/bin/env bash
# fname: ff-onetablink-launch-jbe.sh
# v1_20260529 converts a line:
#             https://www.youtube.com/results?search_query=salsa+hand+toss+flip | (7) salsa hand toss flip - YouTube
#             ... to ...
#             https://www.youtube.com/results?search_query=salsa+hand+toss+flip;salsa hand toss flip
# v2_20260529 output into array
# v3_20260529 output into associative array
# last 20260529
# ---

# globals
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
FFCMD='/usr/bin/firefox'
FZFCMD="fzf -e --reverse --border rounded"

unset llist
declare -A llist

usage() {
	cat <<"EOF"
	Usage: ff-onetablink-launch-jbe <filename>

EOF
}


# MAIN
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

# load lines from file into array
while IFS= read LINE; do
	if [ "${#LINE}" -lt 2 ]; then
		continue
	fi

	converted_line="$(echo $LINE | sed -e 's/\([^ ]\+\) | \(.*\)/\1;\2/' -e 's/([[:digit:]]\+) //' -e '/\S/!d'  -e 's/ - YouTube//')"
	url=${converted_line%%;*}
	dscr=${converted_line#*;}

	llist["${url}"]="${dscr}"

done < "${fjl}"

# selection - fzf
selection="$(for descrp in "${llist[@]}"; do
	echo "${descrp}"
done | ${FZFCMD})"

# run
for URL in ${!llist[@]}; do
	if [[ "${llist["${URL}"]}" =~ "${selection}" ]]; then
	nohup ${FFCMD} "${URL}" >&/dev/null &
	exit
	fi
done

printf "\n"

