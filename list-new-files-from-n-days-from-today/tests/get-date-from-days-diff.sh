#! /usr/bin/env bash
# fname: get-date-from-days-diff.sh
# 20260902 v1
# 20260902 v2 fixed value of start_date if days_diff is  lower tham or equal to zero
#             with retruning from function
# ---

	if [ $# -ne 1 ]; then
		printf "\tUsage: get_start_date_from_daysdiff <daysdiff [int]>\n\n"
		exit
	else
		days_back="$1"
	fi


get_start_date_from_daysdiff() {
	days_diff=0

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
		month_days[2]=29
		year_days=366
	fi

	if [ $# -ne 1 ]; then
		printf "\tUsage: get_start_date_from_daysdiff <daysdiff [int]>\n\n"
		exit
	else
		days_diff="$1"
	fi

	# v2
	if [ "${days_diff}" -le 0 ]; then
		start_date="${currdt}"
		printf "start date: %s\n" "${start_date}"
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
	printf "start date: %s\n" "${start_date}"
}

get_start_date_from_daysdiff ${days_back}

