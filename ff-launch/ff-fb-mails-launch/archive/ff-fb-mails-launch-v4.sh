#! /usr/bin/env bash
# filename: ff-fb-mails-launch.sh
# descpt: open fb-mails links in Firefox from fzf list
# 20261006 v4: add sellection counter 'num_selected'
# last: 20261006
# ---

# === GLOBALS ===
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
fb_files_list="${SRCDIR}/fb_files_list.txt"
unset num_selected
num_selected=0

unset fb_files
declare -A fb_files=()

# === FUNCTIONS ===
FZFCMD() {
	fzf -e --reverse
}

fb_files_list_update() {
	local fb_url
	local fb_fname

	> "${fb_files_list}" 
	for FFF in "${SRCDIR}"/messages/*; do
		fb_url=$(grep '^https://www.facebook.com/share' "$FFF")
		fb_url=$(echo ${fb_url// /})
		if [ x"${fb_url}" == "x" ]; then
			continue
		else
			fb_fname="${FFF##*/}"
			fb_fname="${fb_fname//.txt/}"
			printf "%s;%s\n" "${fb_url}" "${fb_fname}" >> "${fb_files_list}"
		fi
	done
}

fb_files_load() {
	local fb_url
	local fb_fname

	echo "[i] loading messages ..."
	while IFS= read -r LINE; do
		fb_url="${LINE%;*}"
		fb_fname="${LINE#*;}"
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

	echo "[i] selected: ${selection} | ${fb_files["${selection}"]}"
	(nohup ${FFCMD} "${fb_files["${selection}"]}" &) >/dev/null 2>&1
	((num_selected++))
}

# === MAIN ===
if [ $# -eq 1 ]; then
	if [ "$1" == "-u" ] || [ "$1" == "--update" ]; then
		echo "[i] updating ${fb_files_list} ..."
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

