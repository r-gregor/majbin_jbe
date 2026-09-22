#! /usr/bin/env bash
# fname: lvedit-scripts-by-last-timestamp_jbe.sh
# v1_20260520
# v2_20260520 add fzf single selection
# v3_20260220 fzf to multiple selections to open in vim
# v4_20260521 refactor parts of code into functions and introduce main()
# v5_20260521 open in vim
# last: 20260521
# ---

unset fjls_lst
unset selections

declare -a fjls_lst
declare -a selections

currdtstmp=$(date +"%Y%m%d")

dest_jbe="/home/rgregor/majstaf/majbin"
FZFCMD='fzf -e -m --reverse --border rounded'
VIM_CMD="/usr/bin/vim"

usage() {
cat << "EOF"
	Usage: list-scripts-by-last-timestamp <datestamp>
		<datestamp> format: YYYYmmdd ("20260520")
                            at least YYYYmm

EOF
}


load_files_into_list() {
	for FFF in $(find ${dest_jbe}/* -name "*\.sh" | grep -v 'src/'); do
		dtstmp=$(grep last "$FFF" | grep -Eo "[0-9]{8}")
		if [ $? -eq 0 ]; then
			if [[ ${dtstmp} =~ ${djt} ]]; then
				fjls_lst+=("${FFF};${dtstmp}")
			else
				continue
			fi
		else
			continue
		fi
	done

	if [ ${#fjls_lst[@]} -eq 0 ]; then
		printf "[INFO] no file with datestamp: '%s' found\n\n" "${dtstmp}"
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

	selections+=$((for FJL in ${fjls_lst[@]}; do
		while IFS=';' read fname dtstmp; do
			echo "${fname}"
		done < <(echo ${FJL})
	done) | ${FZFCMD})

	if [ "${#selections[@]}" -eq 0 ]; then
		printf "[INFO] nothing selected\n\n"
		exit 1
	fi

	for selection1 in ${selections[@]}; do
		if [[ "${selection1}" == "Quit" ]]; then
			printf "[INFO] nothing selected\n\n"
			exit 1
		fi
	done

	# info
	printf "[INFO] Selected:\n"
	for selection2 in ${selections[@]}; do
		printf "${selection2}\n"
	done
	printf "\n"

	# open in vim
	for selection2 in ${selections[@]}; do
		printf "${selection2} "
	done | xargs -ro ${VIM_CMD}
	printf "\n"
}


#MAIN
main "$@"

