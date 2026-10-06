#! /usr/bin/env bash
# fname: ff-onetablink-launch.sh
# descpt: open onetablinks in Firefox with fzf list from external file
# 20261006 v7: add sellection counter 'num_selected'
# last: 20261006
# ---

# === GLOBALS ===
# SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
unset llist
declare -A llist
unset num_selected
num_selected=0

# === FUNCTIONS ===
usage() {
	cat <<"EOF"
	Usage: ff-onetablink-launch <filename>

EOF
}

FZFCMD() {
	fzf -e --reverse
}

ff_onetablink_launch() {
	selection=$( (for descrp in "${llist[@]}"; do echo "${descrp}"; done; echo '----'; echo 'Quit') | FZFCMD ) #v4

	#v4
	if [ "${selection}" == "" ]; then
		printf "[i] nothing selected\n"
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
	for URL in "${!llist[@]}"; do
		if [[ "${llist["${URL}"]}" =~ ${selection} ]]; then
			printf "[i] selected: %s\n" "${selection}" #v4
			(nohup ${FFCMD} "${URL}" &) > /dev/null 2>&1
			((num_selected++))
		fi
	done
}

# === MAIN ===
if [ $# -ne 1 ]; then
	usage
	exit
else
	fjl="$1"
	if [ ! -f "${fjl}" ]; then
		printf "%s\n\n" "[E] No such file: ${fjl}"
		exit
	fi
fi

while IFS= read -r LINE; do
	if [ "${#LINE}" -lt 2 ]; then
		continue
	fi

	converted_line="$(echo "$LINE" | sed -e 's/\([^ ]\+\) | \(.*\)/\1;\2/' -e 's/([[:digit:]]\+) //' -e '/\S/!d')"
	url=${converted_line%%;*}
	dscr=${converted_line#*;}

	llist["${url}"]="${dscr}"

done < "${fjl}"

while true; do
	ff_onetablink_launch
done

printf "\n"

