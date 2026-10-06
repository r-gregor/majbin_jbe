#! /usr/bin/env bash
# filename: ff-fb-from-mbox-launch-mdb.sh
# descpt: open fb-link in Firefox from fzf list from mbox file
# 20261006 v3: add sellection counter 'num_selected'
# last: 20261006
# ---

# === GLOBALS ===
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

unset num_selected
num_selected=0

fb_files_list="${SRCDIR}/data/fb_files_list_from_mbox.txt"

unset fb_files
declare -A fb_files=()

# === FUNCTIONS ===
FZFCMD() {
	fzf -e --reverse
}

fb_files_list_update() {
	local fb_fname
	local fb_url
	> "${fb_files_list}"
	for FFF in "${SRCDIR}"/messages/*; do
		fb_url=$(grep '^https://www.facebook.com/share' "${FFF}")
		fb_url="${fb_url// /}"
		if [ "${fb_url}" == "" ]; then
			continue
		else
			fb_fname="${FFF##*/}"
			fb_fname="${fb_fname//.txt/}"
			printf "%s;%s\n" "${fb_url}" "${fb_fname}" >> "${fb_files_list}"
		fi
	done
}

fb_files_load() {
	printf "[i] loading messages ...\n"
	while IFS= read -r LINE; do
		local fb_url="${LINE%;*}"
		local fb_fname="${LINE#*;}"
		fb_files+=(["${fb_fname}"]="${fb_url}")
	done <"${fb_files_list}"
	fb_files+=(["Quit"]="Quit")
}


fb_launch() {
	selection=$(for EL in "${!fb_files[@]}"; do echo "${EL}"; done | sort -nr | FZFCMD)

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

	printf "[i] selected: ${selection} | ${fb_files[${selection}]}\n"
	(nohup "${FFCMD}" "${fb_files["${selection}"]}" &) >/dev/null 2>&1
	((num_selected++))
}

# === MAIN ===
if [ $# -eq 1 ]; then
	if [ "$1" == "-u" ] || [ "$1" == "--update" ]; then
		printf "[i] updating ${fb_files_list} ...\n"
		fb_files_list_update
	fi
	fb_files_load
else
	fb_files_load
fi

while true; do
	fb_launch
done

printf "\n"

