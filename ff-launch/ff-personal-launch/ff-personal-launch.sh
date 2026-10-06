#! /usr/bin/env bash
# filename: ff-personal-launch.sh
# descpt: open url-link in Firefox with fzf list from external file
# from ff-launch
# 20261006 v9: add sellection counter
# last: 20261006
#---

clear

# === GLOBALS ===
unset URLS
unset KEYS

SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
FNAME="personal_links_list"
FPTH="${SRCDIR}/${FNAME}"

unset num_selected
num_selected=0

declare -A URLS

# === FUNCTIONS ===
FZFCMD() {
	fzf -e --reverse
}

load_links_into_array() {
	while IFS=';' read -r key value; do
		URLS["${key}"]="${value}"
	done < "${FPTH}"
}

get_longest() {
	if [ ! $# -eq 1 ]; then
		printf "[E1] must supply array of sentences as parameter\n"
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
	local selection=$( (for KEY in "${KEYS[@]}"; do echo "${KEY}"; done | sort; echo "${delline}" ; echo "Quit") | FZFCMD )

	if [ "${selection}" == "" ]; then
		printf "[i] nothing selected\n\n"
		exit 0
	fi

	if [ "${selection}" == "Quit" ]; then
		if [ "${num_selected}" -eq 0 ]; then
			printf "[i] nothing selected\n"
		fi
		printf "\n"
		exit 0
	fi

	if [ "${selection}" != "${delline}" ]; then
		printf "[i] selected: ${selection}\n"
		(nohup ${FFCMD} "${URLS["${selection}"]}" &) > /dev/null 2>&1
		((num_selected++))
	fi
}

# === MAIN ===
load_links_into_array

KEYS=("${!URLS[@]}")

longest_l=$(get_longest KEYS)
delline=$(for((i = 0; i < ${#longest_l}; i++)); do printf "-"; done)

while true; do
	ff_personallaunch
done

printf "\n"

