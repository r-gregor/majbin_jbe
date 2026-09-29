#! /usr/bin/env bash
# filename: gt-testing-status.sh
# descpt: git-status to all testing repositories
# 20241216: store output of commands into array instead of external filea
# 20241218: read output of cmd directly into array, no more need to run cmd twice
#           c-style for loop
# 20250301: correct output messaging
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

TSTDST="${HOME}/majstaf/coding2/testing"
COLOR_SET="\e[1;92m"
COLOR_RESET="\e[0m"
CURRDIR="$PWD"

unset msg
unset report
unset output
report=()
> $TESTING_STATUS_REPORTS

get_status() {
	cmd="$1"
	output=()
	readarray -t -O "${#output[@]}" output < <("${cmd}" status)
	echo "${output[@]}" | grep -i "git push\|untracked\|modified\|deleted" > /dev/null

	if [[ $? -ne 0 ]]; then
		printf "[i] checking git status in ${DDD} ..."
		printf " no action required\n"
	else
		printf -- "---\n"
		printf "${COLOR_SET}"
		msg=$(echo -e "[REPORT] checking git status in ${DDD} ... NEED TO ADD and/or COMMIT\n")
		printf "$msg"
		printf "${COLOR_RESET}"
		readarray -t -O "${#report[@]}" report < <(echo -e "$msg")

		for (( i=0; i<${#output[@]}; i++ )); do
			printf ">\t${output[$i]}"
		done

		printf -- "---\n"
	fi
}

printf "========================================\n"
printf "[i] running gtesting-status ...\n"
printf "========================================\n"
cd "${TSTDST}" || exit 1
for DDD in $(find * -maxdepth 0 -type d | grep -v "vlpprs_${HST}"); do
	cd "$DDD" &> /dev/null

	get_status "/usr/bin/git"
	cd ..
done

printf "${COLOR_SET}"
if [ ${#report[@]} -gt 0 ]; then
	printf "\n"
	for (( j=0; j<${#report[@]}; j++ )); do
		# printf "*** ${report[$j]} ***\n"
		printf "*** ${report[$j]} ***\n" | tee -a $TESTING_STATUS_REPORTS
		
		
	done
else
	printf "\n"
	printf "*** [REPORT] No action required ***\n"
fi
printf "${COLOR_RESET}"

cd "${CURRDIR}" || exit 1

printf "\n"

