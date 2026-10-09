#! /usr/bin/env bash
# filename: knowledgedb-copy-file-to-category.sh
# descpt: copy supplied file/files to knowledgedb into fzf-selected category
# 20260409 jbe: multiple files, with checks ...
# last: 20260409
# ---

# === GLOBALS ===
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
DEST="${HOME}/majstaf/${HST}git/knowledgedb"

# === FUNCTIONS ===
FZFCMD() {
	fzf -e --reverse
}

# === MAIN ===
if [ $# -lt 1 ]; then
	printf "[E] usage: knowledgedb-copy-file-to-category <filename>\n\n"
	exit 1
fi

# 20260409
declare -a fjls;

while [ "$1" ]; do
	fjls+=("$1")
	shift
done

if [ "${#fjls[@]}" -lt 1 ]; then
	printf "[E] No files selected\n\n"
	exit 1
fi

for ((i=0; i<"${#fjls[@]}"; i++)); do
	if [ ! -f "${fjls[i]}" ]; then
		printf "[E] file: '%s' does NOT exist\n\n" "${fjls[i]}"
		exit
	fi
done

CATEGORY=$(ls -1 "${DEST}" | FZFCMD)

printf "[i] move selected files:\n"
for ((j=0; j<"${#fjls[@]}"; j++)); do
	printf "[i] '%s'\n" "${fjls[j]}"
done
printf "[?] to .../%s (y/n)?  " "${CATEGORY}"
read -r ans

if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
	for ((k=0; k<"${#fjls[@]}"; k++)); do
		cp -iv ./"${fjls[k]}" "${DEST}/${CATEGORY}/"
	done
else
	printf "[i] No files moved\n\n"
	exit 0
fi

printf "\n"

