#! /usr/bin/env bash
# filename: get-fb-mails-jbe
# 20260216 jbe v1
# 20260223 en v2
# 20260306 en v3: add 'sort -nr' in 'selection=...' to sort by datestamp
#                 rename directory and filename from get-fb-mails-en to: ff-fb-mails-launch-en
# last: 20260306
# ---

# globals
FFCMD='/usr/bin/firefox'
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
# FZFCMD="fzf -e --reverse --height 50% --border rounded"
FZFCMD="fzf -e --reverse --border rounded"
fb_files_list="${SRCDIR}/fb_files_list.txt"

unset fb_files
declare -A fb_files=()

fb_files_list_update() {
	> ${fb_files_list}
	# for FFF in ./messages/*; do
	for FFF in ${SRCDIR}/messages/*; do
		local fb_url=$(grep '^https://www.facebook.com/share' "$FFF")
		fb_url=$(echo ${fb_url// /})
		if [ x"${fb_url}" == "x" ]; then
			continue
		else
			local fb_fname="$(echo "${FFF##*/}")"
			fb_fname="$(echo "${fb_fname//.txt/}")"
			printf "%s;%s\n" "${fb_url}" "${fb_fname}" >> "${fb_files_list}"
		fi
	done
}

fb_files_load() {
	echo "[INFO] loading messages ..."
	while IFS= read -r LINE; do
		local fb_url="$(echo "${LINE%;*}")"
		local fb_fname="$(echo "${LINE#*;}")"
		fb_files+=(["${fb_fname}"]="${fb_url}")
	done < ${fb_files_list}
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
	# selection=$(for EL in "${!fb_files[@]}"; do echo "${EL}"; done | ${FZFCMD})           #v3
	selection=$(for EL in "${!fb_files[@]}"; do echo "${EL}"; done | sort -nr | ${FZFCMD})  # SORT BY TIMESTAMP

	if [ "x${selection}" == "x" ]; then
		echo -e "[INFO] nothing selected\n"
		exit 0
	fi

	if [ "${selection}" == "Quit" ]; then
		exit 0
	fi

	echo "[INFO] selected: ${selection} <${fb_files["${selection}"]}>"
	nohup ${FFCMD} "${fb_files["${selection}"]}" >&/dev/null &
}

while true; do
	fb_launch
done

