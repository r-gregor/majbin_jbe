#! /usr/bin/env bash
# filename: knowledgedb-copy-file-to-category.sh
# descpt: copy file to a cathegory in $KNOWLEDGEDB
# 20251118 v1
# 20260409 v2: multiple files, with checks ...
# 20261021
# last: 20261021
# ---

# === GLOBALS ===
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
DEST="${HOME}/majstaf/${HST}git/knowledgedb"
declare -a fjls;

# === MAIN ===
if [ $# -lt 1 ]; then
	printf "[e] usage: knowledgedb-copy-file-to-category <filename>\n\n"
	exit 1
fi

while [ "$1" ]; do
	fjls+=("$1")
	shift
done

if [ "${#fjls[@]}" -lt 1 ]; then
	printf "[e] no files selected\n\n"
	exit 1
fi

for ((i=0; i<"${#fjls[@]}"; i++)); do
	if [ ! -f "${fjls[i]}" ]; then
		printf "[e] no such file:'%s'\n" "${fjls[i]}\n\n"
		exit 1
	fi
done

CATEGORY=$(ls -1 ${DEST} | fzf -e --reverse)

printf "[i] copy selected files:\n"
for ((j=0; j<"${#fjls[@]}"; j++)); do
	printf "[i] '%s'\n" "${fjls[j]}"
done
printf "[i] to .../%s (y/n)?  " "${CATEGORY}"
read -r ans

if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
	for ((k=0; k<"${#fjls[@]}"; k++)); do
		cp -iv ./"${fjls[k]}" "${DEST}/${CATEGORY}/"
	done
	printf "\n"
else
	printf "[!] no files copied\n\n"
	exit 0
fi

printf "\n"

