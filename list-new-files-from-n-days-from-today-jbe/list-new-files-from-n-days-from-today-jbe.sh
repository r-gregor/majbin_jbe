#! /usr/bin/env bash
# fname: list-new-files-from-n-days-from-today-en.sh
# 20260731 v1
# 20260809 v2 refine find command to prune (not desend into unwanted drectories
# 20260810 v3 add options to select path and days difference
# 20260810 v4 put find command into function
# 20260902 v5 new get_start_date_from_daysdiff() function
# 20260902 v6 fixed value of start_date if days_diff is  lower tham or equal to zero
#             with retruning from function
# last 20260810
# ---

usage() {
	printf "\n\tUsage: <scriptname> <path (optional)> <days difference to go back from today>\n"
	printf "\n\t                    if <path> nor given --> path is current directory (\".\")\n\n"
}

list_new_files() {
	find "${PTH}" \( \
		-path '**/.config*' \
		-o -path '**/jbegit' \
		-o -path '**/.*' \
		-o -path '**/snap' \
		-o -path '**/_NERAZPOREJENO' \) \
	-prune -o -newerct "${newdate}" -type f -print
}

get_start_date_from_daysdiff() {
	days_diff=0

	if [ $# -ne 1 ]; then
		printf "\tUsage: get_start_date_from_daysdiff <daysdiff [int]>\n\n"
		exit
	else
		days_diff="$1"
	fi

	curryr_str=$(date +"%Y")
	currmn_str=$(date +"%m")
	currdy_str=$(date +"%d")
	currdt=$(date +"%Y%m%d")

	currmn="${currmn_str#0}"
	currdy="${currdy_str#0}"
	curryr="${curryr_str}"

	startmn="${currmn}"
	startdy="${currdy}"
	startyr="${curryr}"

	year_days=365

	month_days=(0 31 28 31 30 31 30 31 31 30 31 30 31)

	if [ $(( !(year % 4) && ( year % 100 || !(year % 400) ) )) ]; then
		year_days=366
		month_days[2]=29
	fi


	# v6
	if [ "${days_diff}" -le 0 ]; then
		start_date="${currdt}"
		printf "${start_date}"
		return
	fi

	if [ "${days_diff}" -ge ${year_days} ]; then
		printf "[ERROR] to many days back (over a whole year)\n\n"
		exit
	fi

	if [ ${startdy} -le ${days_diff} ]; then
		(( startmn-- ))
		(( days_diff -= ${startdy} ))
		startdy=${month_days["${startmn}"]}
		while [ "${month_days["${startmn}"]}" -lt "${days_diff}" ]; do
			(( startmn-- ))
			(( days_diff -= "${month_days["${startmn}"]}" ))
		done
		startdy=$(( "${month_days["${startmn}"]}" - "${days_diff}" ))
	else
		startdy=$(( ${currdy} - ${days_diff} ))
	fi

	if [ ${startdy} -eq 0 ]; then
		(( startmn-- ))
		startdy="${month_days["${startmn}"]}"
	fi

	start_date=$(printf "%04d%02d%02d" "${startyr}" "${startmn}" "${startdy}")
	printf "${start_date}"
}

if [ $# -eq 2 ]; then
	PTH="${1}"
	ddiff=${2}
elif [ $# -eq 1 ]; then
	PTH='.'
	ddiff=${1}
else
	usage
	printf "\n"
	exit 1
fi

if [ ! -d "${PTH}" ]; then
	printf "[ERROR] no such directory: '%s'\n\n" "${PTH}"
	exit 1
fi

newdate="$(get_start_date_from_daysdiff ${ddiff})"

# TEST
# printf "newdate: %s\n" "${newdate}"
# read -p "OK?"

# MAIN
list_new_files

