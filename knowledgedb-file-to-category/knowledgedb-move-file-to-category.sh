#! /usr/bin/env bash
# filename: knowledgedb-move-file-to-category.sh
# descpt: move file to a cathegory in $KNOWLEDGEDB
# 20260409 v1: multiple files, with checks ...
# 20261021
# last: 20261021
# ---

# === GLOBALS ===
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
DEST="${HOME}/majstaf/${HST}git/knowledgedb"
declare -a fjls;

# === MAIN ===
if [ $# -lt 1 ]; then
	printf "[e] usage: knowledgedb-move-file-to-category <filename>\n\n"
	exit 1
fi

while [ "$1" ]; do
	fjls+=("$1")
	shift
done

if [ "${#fjls[@]}" -lt 1 ]; then
	printf "[!] no files selected\n\n"
	exit 0
fi

for ((i=0; i<"${#fjls[@]}"; i++)); do
	if [ ! -f "${fjls[i]}" ]; then
		printf "[e] no such file:'%s'\n" "${fjls[i]}\n\n"
		exit 1
	fi
done

CATEGORY=$(ls -1 ${DEST} | fzf -e --reverse)

printf "[i] move selected files:\n"
for ((j=0; j<"${#fjls[@]}"; j++)); do
	printf "[i] '%s'\n" "${fjls[j]}"
done
printf "[?] to .../%s (y/n)?  " "${CATEGORY}"
read -r ans

if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
	# mv -iv ./"${fname}" "${DEST}/${CATEGORY}/"
	for ((k=0; k<"${#fjls[@]}"; k++)); do
		mv -iv ./"${fjls[k]}" "${DEST}/${CATEGORY}/"
	done
	printf "\n"
else
	printf "[!] no files moved\n\n"
	exit 0
fi

printf "\n"

