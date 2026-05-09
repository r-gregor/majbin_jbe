#! /usr/bin/env bash
# filename: ff-personal-launch-jbe
# from ff-launch-en
# 20260216
# 20260229 v2: add info what was selected
#              change the fzf display to full height
#              inside infinite while loop --> Quit to quit
# 20260229 v3: keys in separate array for arranged order with 'Quit' as last option
# 20260303 v4: added $delline
# 20260304 v5: $delline calculated from longest KEY line with get_longest function
#              sorted output to fzf command
# 20260305 v6: extract KEYS from URLS
# 20260508 v7: move links to external (csv format with ';' delimiter) file and add load_links_into_array()
#              function to load links from file into associative array
# last: 20260508
#---

clear
unset URLS
unset KEYS

# globals
FFCMD='/usr/bin/firefox'
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
# FZFCMD_EN="fzf -e --reverse"   # cygwin version does not support --width option
# FZFCMD="fzf -e --reverse --height 50% --border rounded"
FZFCMD='fzf -e --reverse --border rounded'
FNAME="personal_links_list_jbe" # v7
FPTH=${SRCDIR}/${FNAME}         # v7

# assoc array
declare -A URLS

# functions
# v7
load_links_into_array() {
	while IFS=';' read key value; do
		URLS["${key}"]="${value}"
	done < "${FPTH}"
}

get_longest() {
	if [ ! $# -eq 1 ]; then
		echo "[ERROR1] must supply array of sentences as parameter"
		exit 1
	fi

	local len=0
	local longest
	local -n lines2=$1 # new way: must call array as < array_name >

	for line in "${lines2[@]}"; do
		llen="${#line}"
		if [ "${llen}" -gt "${len}" ]; then
			len="${llen}"
			longest="${line}"
		else
			continue
		fi
	done

	echo "${longest}"
}

ff_personallaunch() {
	local selection=$((for KEY in "${KEYS[@]}"; do echo "$KEY"; done | sort; echo "${delline}" ; echo "Quit") | fzf --reverse)

	if [ "x${selection}" == "x" ]; then
		echo -e "[INFO] nothing selected\n"
		exit 0
	fi

	if [ "${selection}" == "Quit" ]; then
		# echo -e "[INFO] leaving\n"
		exit 0
	fi

	if [ "${selection}" != "${delline}" ]; then
		echo "[INFO] selected: ${selection}"
		nohup ${FFCMD} "${URLS["${selection}"]}" >&/dev/null &
	fi
}

# MAIN
load_links_into_array # v7

# array of keys from URLS
KEYS=("${!URLS[@]}")

longest_l=$(get_longest KEYS)
delline=$(for((i = 0; i < ${#longest_l}; i++)); do printf "-"; done)

while true; do
	ff_personallaunch
done

