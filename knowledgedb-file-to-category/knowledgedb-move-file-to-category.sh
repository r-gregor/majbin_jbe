#! /usr/bin/env bash
# filename: knowledgedb-move-file-to-category
# 20260409 jbe: multiple files, with checks ...
# last: 20260409
# ---

# globals
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
DEST="/home/rgregor/majstaf/jbegit/knowledgedb"

if [ $# -lt 1 ]; then
	echo -e "usage: $0 <filename>\n"
	exit
fi

# 20260409
declare -a fjls;

while [ "$1" ]; do
	fjls+=("$1")
	shift
done

if [ "${#fjls[@]}" -lt 1 ]; then
	printf "[INFO] No files selected"
	exit
fi

for ((i=0; i<"${#fjls[@]}"; i++)); do
	if [ ! -f "${fjls[i]}" ]; then
		printf "[ERROR] file: '%s' does NOT exist\n" "${fjls[i]}"
		printf "\n"
		exit
	fi
done

CATEGORY=$(ls -1 ${DEST} | fzf -e --reverse)

printf "[INFO] move selected files:\n"
for ((j=0; j<"${#fjls[@]}"; j++)); do
	printf "[INFO] '%s'\n" "${fjls[j]}"
done
printf "[INFO] to .../%s [y/n]?  " "${CATEGORY}"
read -r ans

if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
	# mv -iv ./"${fname}" "${DEST}/${CATEGORY}/"
	for ((k=0; k<"${#fjls[@]}"; k++)); do
		mv -iv ./"${fjls[k]}" "${DEST}/${CATEGORY}/"
	done
	printf "\n"
else
	printf "[INFO] No files moved\n"
	printf "\n"
	exit
fi

