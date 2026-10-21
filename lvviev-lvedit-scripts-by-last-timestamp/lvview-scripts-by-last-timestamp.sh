#! /usr/bin/env bash
# fname: lvview-scripts-by-last-timestamp.sh
# descpt: View script in vim with FZF sellection with timestamp
# 20260520 v1
# 20260520 v2: add fzf single selection
# 20260220 v3: fzf to multiple selections to open in vim
# 20260521 v4: refactor parts of code into functions and introduce main()
# 20260521 v5: open in vim
# 20260917 v6: put FZFCMD into function
# last: 20260917
# ---


# === GLOBALS ===
unset fjls_lst
unset selections
declare -a fjls_lst
declare -a selections

currdtstmp=$(date +"%Y%m%d")

DEST="${HOME}/majstaf/majbin"
VIM_CMD="/usr/bin/vim -M"

# === FUNCTIONS ===
usage() {
	printf "[!] usage: lvview-scripts-by-last-timestamp <datestamp>\n"
	printf "           <datestamp> format: YYYYmmdd ("20260520")\n"
    printf "                      at least YYYYmm\n\n"
}

FZFCMD_EN() {
	fzf -e -m --reverse # cygwin version does not support --width option
}

load_files_into_list() {
	for FFF in $(find "${DEST}" -name "*\.sh" | grep -v 'archive/'); do
		dtstmp=$(grep last "$FFF" | grep -Eo "[0-9]{8}")
		if [ $? -eq 0 ]; then
			if [[ "${dtstmp}" =~ ${djt} ]]; then
				fjls_lst+=("${FFF};${dtstmp}")
			else
				continue
			fi
		else
			continue
		fi
	done

	if [ "${#fjls_lst[@]}" -eq 0 ]; then
		printf "[e] no file with datestamp: '%s' found\n\n" "${dtstmp}"
		exit 1
	fi

	fjls_lst+=("---;${currdtstmp}")
	fjls_lst+=("Quit;${currdtstmp}")
}

# v3
main() {
	if [ $# -ne 1 ]; then
		usage
		exit 1
	elif [ ${#1} -gt 8 ] || [ ${#1} -lt 6 ]; then
		usage
		exit 1
	else
		djt="$1"
		load_files_into_list
	fi

	selections+=$((for FJL in "${fjls_lst[@]}"; do
		while IFS=';' read fname dtstmp; do
			echo "${fname}"
		done < <(echo "${FJL}")
	done) | FZFCMD_EN)

	if [ "${#selections[@]}" -eq 0 ]; then
		printf "[!] nothing selected\n\n"
		exit 0
	fi

	for selection1 in "${selections[@]}"; do
		if [[ "${selection1}" == "Quit" ]]; then
			printf "[!] nothing selected\n\n"
			exit 0
		fi
	done

	# info
	printf "[i] Selected:\n"
	for selection2 in "${selections[@]}"; do
		printf "${selection2}\n"
	done
	printf "\n"

	# open in vim
	for selection2 in "${selections[@]}"; do
		printf "${selection2} "
	done | xargs -ro ${VIM_CMD}
	printf "\n"
}


# === MAIN ===
main "$@"

printf "\n"

