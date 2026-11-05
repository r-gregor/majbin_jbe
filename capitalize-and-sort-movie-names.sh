#! /usr/bin/env bash
# fname: capitalize-and-sort-movie_names.sh
# descpt: capitalize each word in movie names from file
# depends: tr, sed, sort, uniq
# 20261105 v1
# last: 20261105
# ---

# === GLOBALS ===
filename="MOVIES_CHECKOUT.txt"


# === FUNCTIONS ===
usage() {
	printf "[!] usage: capitalize-and-sort-movie_names <filename with movies names>\n"
}

capitalize_word() {
	local FIRST_LETTER
	local WORD

	if [ $# -ne 1 ]; then
		printf "[e] must supply a WORD to capitalize\n\n"
		exit 1
	else
		WORD="${1}"
	fi

	FIRST_LETTER=$(printf "${WORD:0:1}" | tr "[:lower:]" "[:upper:]")
	printf "%s" "${FIRST_LETTER}"
	printf "%s" "${WORD:1} " | tr "[:upper:]" "[:lower:]"
}

capitalize_and_sort() {
	if [ $# -ne 1 ]; then
		printf "[e] no filename supplied\n"
		usage
		printf "\n"
		exit 1
	fi

	FILENAME="${1}"
	while read -r LINE; do
		for WORD in $LINE; do
			capitalize_word "${WORD}"
		done
		printf "\n"
	done < "${FILENAME}" | sed 's/ ([0-9]\{4\})//' | sort | uniq
}

# === MAIN ===
if [ $# -ne 1 ]; then
	printf "[e] no filename supplied\n"
	usage
	printf "\n"
	exit 1
else
	filename="${1}"
fi

if [ ! -f "${filename}" ]; then
	printf "[e] no such filename '%s' in current directory\n\n" "${filename}"
	exit 1
fi

capitalize_and_sort "${filename}"

