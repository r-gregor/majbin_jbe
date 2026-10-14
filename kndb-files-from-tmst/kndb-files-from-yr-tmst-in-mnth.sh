#! /usr/bin/env bash
# filename: kndb-files-from-yr-tmst-in-mnth-mdb
# descpt: List files in KNOWLEDGEDB from day in month to the end of the month in year
# 20260331 v1: display from newest to oldst: $(seq start end) --> $(seq end -1 start)
# 20260415 v2: final printout to stdout and into xargs in one line with 'tee /dev/tty' comand
# 20260831 v3: fzf files list sorted by cathegory
# 20260925
# last: 20260925
# ---

curryr=$(date +"%Y")
currmn=$(date +"%m")
currdy=$(date +"%d")

scrpt=$(basename $0)

SRCDIR="${KNOWLEDGEDB:-${HOME}/majstaf/${HST}git/knowledgedb}"

months=("" "January" "February" "March" "April" "May" "June" "July" "Avgust" "September" "October" "November" "December")
month_days=(0 31 29 31 30 31 30 31 31 30 31 30 31)

usage() {
cat << EOF
    Usage: ${scrpt} + 3 parameters:
                      <year>
                      <month_num>
                      <day_num>

       or: ${scrpt} + 2 parameters:
                      <month_num>
                      <day_num>
                      (year is current year)


EOF
}

if [ $# -eq 2 ]; then
	slct_yr=$(date +"%Y")
	slct_mnth="$1"
	slct_day="$2"
elif [ $# -eq 3 ]; then
	slct_yr="$1"
	slct_mnth="$2"
	slct_day="$3"
else
	usage
	exit 1
fi


# if [ $# -ne 3 ]; then
# 	echo "Must supply exactly three parameters:"
# 	usage
# 	exit
# else
# 	year=$1
# 	slct_mnth=$2
# 	slct_day=$3
# fi

if [ "${slct_mnth}" -lt 1 ] || [ "${slct_mnth}" -gt 12 ]; then
	printf "[E] month out of range (1 - 12)\n\n"
	exit 1
elif [ "${slct_day}" -lt 1 ] || [ "${slct_day}" -gt 31 ]; then
	printf "[E] day of month out of range (1 - 31)\n\n"
	exit 1
# elif [ "${slct_mnth}" -eq "${currmn}" ] && [ "${slct_day}" -gt "${currdy}" ]; then
elif [ "${slct_yr}" -ge "${curryr}" ] && [ "${slct_mnth}" -eq "${currmn}" ] && [ "${slct_day}" -gt "${currdy}" ]; then
	printf "[E] day of current month out of range\n\n"
	exit 1
fi

unset RESULT
# readarray -t RESULT < <(for DYS in $(seq "${slct_day}" ${month_slct_days["${slct_mnth}"]}); do find ${SRCDIR} -iname "*${slct_yr}"${slct_mnth}"${DYS}.txt"; done)
# readarray -t RESULT < <(for DYS in $(seq "${slct_day}" ${month_slct_days["${slct_mnth}"]}); do find ${SRCDIR} \
readarray -t RESULT < <(for DYS in $(seq "${month_days["${slct_mnth}"]}" -1 "${slct_day}"); do find "${SRCDIR}" \
	-iname $(printf "*%d%02d%02d.txt" "${slct_yr}" "${slct_mnth}" "${DYS}"); done)

if [ "${RESULT[0]}" == "" ]; then
	printf "[E] no files found\n\n"
	exit 1
fi

unset fjls

# v3
# readarray -t fjls < <(for FJL in $(echo "${RESULT[@]}"); do echo "${FJL}"; done | fzf -m -e --reverse)
readarray -t fjls < <(for FJL in $(echo "${RESULT[@]}"); do echo "${FJL}"; done | sort -t'/' -k7 | fzf -m -e --reverse)

if [ "${fjls[0]}" == "" ]; then;
	printf "[i] no files selected\n\n"
	exit 0
fi

printf "[i] selected:\n"
# for FJL in $(echo ${fjls[@]}); do echo "$FJL"; done
# for FJL in $(echo ${fjls[@]}); do echo "$FJL"; done | xargs -ro vim -pM
# v2
for FJL in $(echo "${fjls[@]}"); do echo "${FJL}"; done | tee /dev/tty | xargs -ro vim -pM

printf "\n"

