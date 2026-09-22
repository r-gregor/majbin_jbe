#! /usr/bin/env bash
# fname: list-scripts-by-last-timestamp.sh
# v1_20260520
# v2_20260520 TODO: add fzf to vim stuff ...
# last: 20260520
# ---

unset selections
unset selection

declare -a selections

dest="/home/rgregor/majstaf/majbin"

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
			selections+=("${FFF};${dtstmp}")
		else
			continue
		fi
	else
		continue
	fi
done

if [ ${#selections[@]} -eq 0 ]; then
	printf "[INFO] no file with datestamp: '%s' found\n"
	exit
fi

printf "[INFO] files found:\n"
for FJL in ${selections[@]}; do
	while IFS=';' read fname dtstmp; do
		printf "${dtstmp} -- ${fname}\n"
	done < <(echo ${FJL})
done | sort -nr
printf "\n"

