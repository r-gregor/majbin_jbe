#! /usr/bin/env bash
# filename: ff-checkout-launch.sh
# descpt: Launch www-sites from external file in format: 'http-link;decription'
# from: ff-fb-mails-from-mbox-launch-en.sh
# 20261006 v2: add sellection counter 'num_selected'
# last: 20261006
# ---

# === GLOBALS ===
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
checkout_files_list="${SRCDIR}/data/checkout-sites-list.txt"

unset num_selected
num_selected=0

unset checkout_files
declare -A checkout_files

# === FUNCTIONS ===
FZFCMD() {
	fzf -e --reverse
}

ff_checkout_launch() {
	selection=$( (for descrp in "${checkout_files[@]}"; do echo "${descrp}"; done | sort; echo "----"; echo "Quit") | FZFCMD)

	if [ "${selection}" == "" ]; then
		printf "[i] nothing selected\n\n"
		exit 0
	fi

	if  [ "${selection}" == "----" ]; then
		return
	fi

	if [ "${selection}" == "Quit" ]; then
		if [ "${num_selected}" -eq 0 ]; then
			printf "[i] nothing selected\n"
		fi
		printf "\n"
		exit 0
	fi

	# run
	for URL in "${!checkout_files[@]}"; do
		if [[ "${checkout_files["${URL}"]}" =~ "${selection}" ]]; then
			printf "[i] selected: %s\n" "${selection}" #v4
			# cygstart "${FFCMD}" "${URL}"
			(nohup "${FFCMD}" "${URL}" &) >/dev/null 2>&1
			((num_selected++))
		fi
	done
}

# === MAIN ===
if [ $# -eq 1 ]; then
	checkout_files_list="$1"
	if [ ! -f "${checkout_files_list}" ]; then
		printf "[ERROR] no such file: %s\n\n" "${checkout_files_list}"
		exit 1
	fi
fi

while IFS= read -r LINE; do
	if [ "${#LINE}" -lt 2 ]; then
		continue
	fi

	url=${LINE%%;*}
	dscr=${LINE#*;}
	checkout_files["${url}"]="${dscr}"

done < "${checkout_files_list}"

while true; do
	ff_checkout_launch
done

printf "\n"

