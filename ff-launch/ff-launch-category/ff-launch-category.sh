#! /usr/bin/env bash
# filename: ff-launch-category.sh
# descpt: open url-links in Firefox with fzf list from external file
# 20261006 v8: add sellection counter 'num_selected'
# last: 20261006
# ---

clear

# === GLOBALS ===
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
SITES="${SRCDIR}/sites.txt"
unset num_selected
num_selected=0

# === FUNCTIONS ===
FZFCMD() {
	fzf -e --reverse
}

ff_launch() {
	if [ "$1" == "all" ]; then
		readarray -t URLS < <(cat "${SITES}")
	else
		site="$1"
		readarray -t URLS < <(sed -n "/\[${site}\]/,/^$/p" "${SITES}")
	fi

	selection=$(for URL in "${URLS[@]}"; do echo "$URL"; done 2>/dev/null | FZFCMD)

	if [ "${selection}" == "" ]; then
		printf "[i] nothing selected\n\n"
		exit 0
	fi

	if [[ "${selection}" =~ ^(---) ]]; then
		printf "[i] nothing selected\n\n"
		exit 0
	fi

	if [[ "${selection}" =~ ^\[.*\] ]]; then
		printf "[i] nothing selected\n\n"
		exit 0
	fi

	path=$(echo "${selection}" | cut -d ' ' -f1)
	printf "[i] selected: ${path}\n"
	(nohup ${FFCMD} "${path}" &) > /dev/null 2>&1
	((num_selected++))
}

# === MAIN ===
readarray -t categories < <(sed -n "/\[.*\]/p" "${SITES}" | sed -e 's/\[//' -e 's/\]//')
categories+=("ALL")
categories+=("q (quit)")

while true; do
	selected=$(for WAY in "${categories[@]}"; do echo "${WAY}"; done | fzf +c --reverse)

	if [ "${selected}" == "" ]; then
		printf "[i] nothing selected\n\n"
		exit 0
	fi

	if [ "${selected}" == "q (quit)" ]; then
		if [ "${num_selected}" -eq 0 ]; then
			printf "[i] nothing selected\n"
		fi
		printf "\n"
		exit 0
	fi

	if [ "${selected}" == "ALL" ]; then
		dest="all"
	else
		dest="${selected}"
	fi

	ff_launch "${dest}"
done

printf "\n"

