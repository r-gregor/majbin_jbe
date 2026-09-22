#! /usr/bin/env bash
# filename: ff-fb-mails-launch-jbe.sh
# descpt: Launch with firefox fb-links from mails list in external file
# 20260216 v1
# 20260223 v2
# 20260306 v3: add 'sort -nr' in 'selection=...' to sort by datestamp
#                 rename directory and filename from get-fb-mails-en to: ff-fb-mails-launch-en
# last: 20260306
# ---

# globals
FFCMD='/usr/bin/firefox'
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
# FZFCMD="fzf -e --reverse --height 50% --border rounded"
# FZFCMD="fzf -e --reverse --border rounded"
FZFCMD() {
	fzf -e --reverse --border rounded
}

fb_files_list="${SRCDIR}/fb_files_list.txt"

unset fb_files
declare -A fb_files=()

fb_files_list_update() {
	local fb_url
	local fb_fname
	> "${fb_files_list}"
	# for FFF in ./messages/*; do
	for FFF in "${SRCDIR}"/messages/*; do
		fb_url=$(grep '^https://www.facebook.com/share' "$FFF")
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
	local fb_url
	local fb_fname
	echo "[INFO] loading messages ..."
	while IFS= read -r LINE; do
		fb_url="${LINE%;*}"
		fb_fname="${LINE#*;}"
		fb_files+=(["${fb_fname}"]="${fb_url}")
	done < "${fb_files_list}"
	fb_files+=(["Quit"]="Quit")
}

if [ $# -eq 1 ]; then
	if [ "$1" == "-u" ] || [ "$1" == "--update" ]; then
		echo "[INFO] updating ${fb_files_list} ..."
		fb_files_list_update
	fi
	fb_files_load
else
	fb_files_load
fi

fb_launch() {
	# selection=$(for EL in "${!fb_files[@]}"; do echo "${EL}"; done | FZFCMD)           #v3
	selection=$(for EL in "${!fb_files[@]}"; do echo "${EL}"; done | sort -nr | FZFCMD)  # SORT BY TIMESTAMP

	if [ "${selection}" == "" ]; then
		echo -e "[INFO] nothing selected\n"
		exit 0
	fi

	if [ "${selection}" == "Quit" ]; then
		exit 0
	fi

	echo "[INFO] selected: ${selection} <${fb_files["${selection}"]}>"
	# nohup ${FFCMD} "${fb_files["${selection}"]}" >&/dev/null &
	(nohup ${FFCMD} "${fb_files["${selection}"]}" &) > /dev/null 2>&1
}

while true; do
	fb_launch
done

