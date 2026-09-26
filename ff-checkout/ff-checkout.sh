#! /usr/bin/env bash
# filename: ff-checkout-en.sh
# descpt: Launch www-sites from external file in format: 'http-link;decription'
# from: ff-fb-mails-from-mbox-launch-en.sh
# 20260923
# last: 20260923
# ---

# globals
SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
checkout_files_list="${SRCDIR}/data/checkout-sites-list.txt"

unset checkout_files
declare -A checkout_files

FZFCMD() {
	fzf -e --reverse
}



# MAIN
# load lines from file into array

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

ff_checkout_launch() {
	selection=$( (for descrp in "${checkout_files[@]}"; do echo "${descrp}"; done | sort; echo "----"; echo "Quit") | FZFCMD)

	if [ "${selection}" == "" ]; then
		printf "[INFO] nothing selected\n"
		exit 0
	fi

	if  [ "${selection}" == "----" ]; then
		return
	fi

	if [ "${selection}" == "Quit" ]; then
		printf "\n"
		exit 0
	fi

	# run
	for URL in "${!checkout_files[@]}"; do
		if [[ "${checkout_files["${URL}"]}" =~ "${selection}" ]]; then
		printf "[INFO] selected: %s\n" "${selection}" #v4
		(nohup ${FFCMD} "${URL}" &) >/dev/null 2>&1
		fi
	done
}

#v4
while true; do
	ff_checkout_launch
done
printf "\n"

