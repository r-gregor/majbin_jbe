#! /usr/bin/env bash
# filename: ff-launch--en
# 20251117 v1
# 20251117 v2: :associative array --> no case statement needed
# 20251117 v3: ALL --> cat all txt files into process subst ...
#              no 'all.txt' needed
# 20251118 v4: single "sites.txt" with "[section name]" headers parsing
# 20251118 v5: get 'categories' from 'sites.txt' file directly
# 20260305 v6: put main into infinite while loop
#              output selected to stdot
# 20260917 v7: move FZFCMD command into FZFCMD() function
# last: 20260917

clear

# globals
FFCMD='/usr/bin/firefox'
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
SITES="${SRCDIR}/sites.txt"

FZFCMD() {
	fzf -e --reverse --height 50% --border rounded
}

ff_launch() {
	if [ "$1" == "all" ]; then
		readarray -t URLS < <(cat "${SITES}")
	else
		site="$1"
		# v4
		# readarray -t URLS < <(sed -n "/\[${site}\]/,/^$/p" ${SITES} | sed -n '2,$'p)
		readarray -t URLS < <(sed -n "/\[${site}\]/,/^$/p" "${SITES}")
	fi

	selection=$(for URL in "${URLS[@]}"; do echo "$URL"; done 2>/dev/null | FZFCMD)

	if [ "${selection}" == "" ]; then
		echo -e "[INFO] nothing selected\n"
		exit
	fi

	if [[ "${selection}" =~ ^(---) ]]; then
		echo -e "[INFO] nothing selected\n"
		exit
	fi

	if [[ "${selection}" =~ ^\[.*\] ]]; then
		echo -e "[INFO] nothing selected\n"
		exit
	fi

	path=$(echo "${selection}" | cut -d ' ' -f1)
	echo "[INFO] selected: ${path}"
	# nohup ${FFCMD} "${path}" >&/dev/null &
	(nohup ${FFCMD} "${path}" &) > /dev/null 2>&1
}

# v5
readarray -t categories < <(sed -n "/\[.*\]/p" "${SITES}" | sed -e 's/\[//' -e 's/\]//')
categories+=("ALL")
categories+=("q (quit)")

while true; do
	selected=$(for WAY in "${categories[@]}"; do echo "${WAY}"; done | fzf +c --reverse)

	if [ "${selected}" == "" ]; then
		echo -e "[INFO] nothing selected\n"
		exit
	fi

	if [ "${selected}" == "q (quit)" ]; then
		exit
	fi

	if [ "${selected}" == "ALL" ]; then
		dest="all"
	else
		dest="${selected}"
	fi

	ff_launch "${dest}"
done

