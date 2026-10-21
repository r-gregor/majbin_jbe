#! /usr/bin/env bash
# fname: list-scripts-by-last-timestamp.sh
# v1_20260520
# v2_20260520 add fzf single selection
# last: 20260520
# ---

unset fjls_lst
unset selections
unset selection

declare -a fjls_lst
declare -a selections

dest="/home/gregor.redelonghi/majstaf/majbin"
FZFCMD_EN="fzf -e --reverse"   # cygwin version does not support --width option

usage() {
cat << "EOF"
	Usage: list-scripts-by-last-timestamp <datestamp>
		<datestamp> format: YYYYmmdd ("20260520")
                            at least YYYYmm

EOF
}

if [ $# -ne 1 ]; then
	usage
	exit
elif [ ${#1} -gt 8 ] || [ ${#1} -lt 6 ]; then
	usage
	exit
else
	djt="$1"
fi

for FFF in $(find ${dest}/* -name "*\.sh" | grep -v 'src/'); do
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
	printf "[INFO] no file with datestamp: '%s' found\n"
	exit
fi

# v2
selection=$((for FJL in ${fjls_lst[@]}; do
	while IFS=';' read fname dtstmp; do
		echo "${fname}"
	done < <(echo ${FJL})
done; echo "---"; echo "Quit") | ${FZFCMD_EN})

if [ "x${selection}" == "x" ]; then
	printf "[INFO] nothing selected\n\n"
	exit 0
fi

if [ "${selection}" == "Quit" ] || [ "${selection}" == "---" ] ; then
	printf "\n"
	exit 0
fi

printf "[INFO] Selected: ${selection}\n\n"

