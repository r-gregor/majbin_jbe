#! /usr/bin/env bash
# capitalize-and-sort-movie-names.sh
# descpt: capitalize each word in movie-names from file
# depends: tr, sed, sort, uniq
# 20261105 v1
# last: 20261105
# ---

# === GLOBALS ===
filename="MOVIES_CHECKOUT.txt"


# === FUNCTIONS ===
usage() {
	printf "[!] usage: capitalize-and-sort-movie-names <filename with movie-names>\n"
}

capitalize_word() {
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
	local FILENAME
	local WORD

	if [ $# -ne 1 ]; then
		printf "[e] no filename supplied\n"
		usage
		printf "\n"
		exit 1
	else
		FILENAME="${1}"
	fi

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
	fname_with_movie_names="${1}"
fi

if [ ! -f "${fname_with_movie_names}" ]; then
	printf "[e] no such filename '%s' in current directory\n\n" "${fname_with_movie_names}"
	exit 1
fi

capitalize_and_sort "${fname_with_movie_names}"

