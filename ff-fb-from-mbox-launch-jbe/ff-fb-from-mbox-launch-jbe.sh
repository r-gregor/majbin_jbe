#! /usr/bin/env bash
# filename: ff-fb-from-mbox-launch-jbe.sh
# descpt: Launch fb-links from mbox in Firefox
# 20260721 v1
# last: 20260721
# ---

# globals
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
# FFCMD_EN=/c/Users/gregor.redelonghi/majstaf_en/majprogs_en/FireFox_63.0.1/FirefoxPortable.exe
# FZFCMD_EN="fzf -e --reverse" # cygwin version does not support --width option

FFCMD='/usr/bin/firefox'

FZFCMD() {
	fzf -e --reverse --border rounded
}

fb_files_list="${SRCDIR}/data/fb_files_list_from_mbox.txt"

unset fb_files
declare -A fb_files=()

fb_files_list_update() {
	local fb_url
	local fb_fname
	> "${fb_files_list}"
	for FFF in "${SRCDIR}"/messages/*; do

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
	echo "[INFO] loading messages ..." # CHANGE 20260223 !!!
	local fb_url
	local fb_fname
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

# selection=$(for EL in "${!fb_files[@]}"; do
#    echo "${EL}"
# done | ${FZFCMD_EN})
# cygstart ${FFCMD_EN} ${fb_files[${selection}]}

fb_launch() {
	# selection=$(for EL in "${!fb_files[@]}"; do echo "${EL}"; done | ${FZFCMD_EN})
	selection=$(for EL in "${!fb_files[@]}"; do echo "${EL}"; done | sort -nr | FZFCMD)

	if [ "${selection}" == "" ]; then
		echo -e "[INFO] nothing selected\n"
		exit 0
	fi

	if [ "${selection}" == "Quit" ]; then
		exit 0
	fi

	echo "[INFO] selected: ${selection} <${fb_files[${selection}]}>"
	(nohup ${FFCMD} "${fb_files["${selection}"]}" &) >/dev/null 2>&1
}

while true; do
	fb_launch
done

