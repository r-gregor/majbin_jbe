#! /usr/bin/env bash
# fname: list-new-files-from-n-days-from-today-en.sh
# 20260731 v1
# 20260809 v2 refine find command to prune (not desend into unwanted drectories
# 20260810 v3 add options to select path and days difference
# 20260810 v4 put find command into function
# 20260902 v5 new get_start_date_from_daysdiff() function
# 20260902 v6 fixed value of start_date if days_diff is  lower than or equal to zero
#             with retruning from function
# 20260903 v7 put everithing into list_new_files() function and check if ddiff is a anumber
# last 20260810
# ---

usage() {
	printf "\n\tUsage: <scriptname> <path (optional)> <days difference to go back from today>\n"
	printf "\n\t                    if <path> nor given --> path is curr_ent directory (\".\")\n\n"
}

# v7
list_new_files() {
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
	
	# v7
	if ! [[ "${ddiff}" =~ ^[0-9]+$ ]]; then
		printf "[ERROR] ddiff is not a nubmer\n"
		exit 1
	fi

	newdate="$(get_start_date_from_daysdiff ${ddiff})"
	# if [[ ! ${newdate} =~ '^[0-9]+$' ]]; then
	# 	printf "[ERROR] new date is not a nuber\n"
	# 	exit 1
	# fi

	printf "[INFO] looking for files from %s\n---\n" "${newdate}"
	find "${PTH}" \( \
		-path '**/.config*' \
		-o -path '**/.cache' \
		-o -path '**/mdbgit' \
		-o -path '**/jbegit' \
		-o -path '**/engit' \
		-o -path '**/.*' \
		-o -path '**/snap' \
		-o -path '**/_NERAZPOREJENO' \) \
	-prune -o -newerct "${newdate}" -type f -print
}

get_start_date_from_daysdiff() {
	days_diff=0

	if [ $# -ne 1 ]; then
		printf "\tUsage: get_start_date_from_daysdiff <daysdiff [int]>\n\n"
		exit 1
	else
		days_diff="$1"
	fi

	curr_yr_str=$(date +"%Y")
	curr_mn_str=$(date +"%m")
	curr_dy_str=$(date +"%d")
	curr_dt=$(date +"%Y%m%d")

	curr_mn="${curr_mn_str#0}"
	curr_dy="${curr_dy_str#0}"
	curr_yr="${curr_yr_str}"

	start_mn="${curr_mn}"
	start_dy="${curr_dy}"
	start_yr="${curr_yr}"

	year_days=365

	month_days=(0 31 28 31 30 31 30 31 31 30 31 30 31)

	if [ $(( !(year % 4) && ( year % 100 || !(year % 400) ) )) ]; then
		year_days=366
		month_days[2]=29
	fi


	# v6
	if [ "${days_diff}" -le 0 ]; then
		start_date="${curr_dt}"
		printf "${start_date}"
		return
	fi

	if [ "${days_diff}" -ge ${year_days} ]; then
		printf "[ERROR] to many days back (over a whole year)\n\n"
		exit 1
	fi

	if [ ${start_dy} -le ${days_diff} ]; then
		(( start_mn-- ))
		(( days_diff -= ${start_dy} ))
		start_dy=${month_days["${start_mn}"]}
		while [ "${month_days["${start_mn}"]}" -lt "${days_diff}" ]; do
			(( start_mn-- ))
			(( days_diff -= "${month_days["${start_mn}"]}" ))
		done
		start_dy=$(( "${month_days["${start_mn}"]}" - "${days_diff}" ))
	else
		start_dy=$(( ${curr_dy} - ${days_diff} ))
	fi

	if [ ${start_dy} -eq 0 ]; then
		(( start_mn-- ))
		start_dy="${month_days["${start_mn}"]}"
	fi

	start_date=$(printf "%04d%02d%02d" "${start_yr}" "${start_mn}" "${start_dy}")
	printf "${start_date}"
}


# MAIN
list_new_files "$@"

