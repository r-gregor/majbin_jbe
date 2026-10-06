#! /usr/bin/env bash
# fname: ff-onetablink-launch-mdb.sh
# 20260529 v1 converts a line:
#             https://www.youtube.com/results?search_query=salsa+hand+toss+flip | (7) salsa hand toss flip - YouTube
#             ... to ...
#             https://www.youtube.com/results?search_query=salsa+hand+toss+flip;salsa hand toss flip
# 20260529 v2 output into array
# 20260529 v3 output into associative array
# 20260729 v4 added 'Quit' and checks for false selections
#             put everything into while loop
#             changed 'echo -e' into 'printf'
# 20260817 v5 remove '- Youtube' from sed remplace to include youtube videos ...
# last 20260817
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

	# converted_line="$(echo $LINE | sed -e 's/\([^ ]\+\) | \(.*\)/\1;\2/' -e 's/([[:digit:]]\+) //' -e '/\S/!d'  -e 's/ - YouTube//')"
	# v5
	converted_line="$(echo $LINE | sed -e 's/\([^ ]\+\) | \(.*\)/\1;\2/' -e 's/([[:digit:]]\+) //' -e '/\S/!d')"
	url=${converted_line%%;*}
	dscr=${converted_line#*;}

	llist["${url}"]="${dscr}"

done < "${fjl}"

#v4
ff_onetablink_launch() {
	# selection - fzf
	selection=$((for descrp in "${llist[@]}"; do echo "${descrp}"; done; echo '----'; echo 'Quit') | ${FZFCMD}) #v4

	#v4
	if [ "x${selection}" == "x" ]; then
		printf "[INFO] nothing selected\n"
		exit 0
	fi

	if  [ "${selected}" == "----" ]; then
		continue
	fi

	if [ "${selection}" == "Quit" ]; then
		printf "\n"
		exit 0
	fi

	# run
	for URL in ${!llist[@]}; do
		if [[ "${llist["${URL}"]}" =~ "${selection}" ]]; then
			printf "[INFO] selected: ${selection}\n" #v4
			(nohup ${FFCMD} "${URL}" &) > /dev/null 2>&1
			# exit #v4
		fi
	done
}

#v4
while true; do
	ff_onetablink_launch
done
printf "\n"

