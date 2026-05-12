#! /usr/bin/env bash
# filename: testing-ghgl-status-jbe
# 20241216: store output of commands into array instead of external filea
# 20241218: read output of cmd directly into array, no more need to run cmd twice
#           c-style for loop
# last change: 202500831

HST="jbe"
TSTDST=${HOME}/majstaf/coding2/testing
COLOR_SET="\e[1;92m"
COLOR_RESET="\e[0m"
CURRDIR=$PWD

unset msg
unset report
unset output
report=()
> $TESTING_STATUS_REPORTS

get-status() {
	cmd=$1
	output=()
	readarray -t -O ${#output[@]} output < <(${cmd} status)
	echo ${output[@]} | grep -i "git push\|untracked\|modified\|deleted" > /dev/null

	if [[ $? -ne 0 ]]; then
		echo -n "[INFO] checking git status in ${DDD} ..."
		echo " no action required"
	else
		echo "---"
		printf "${COLOR_SET}"
		msg=$(echo -e "[REPORT] checking git status in ${DDD} ... NEED TO ADD and/or COMMIT\n")
		echo -e "$msg"
		printf "${COLOR_RESET}"
		readarray -t -O "${#report[@]}" report < <(echo -e "$msg")

		for (( i=0; i<${#output[@]}; i++ )); do
			echo -e ">\t${output[$i]}"
		done


		echo "---"
	fi
}

echo "========================================"
echo "[INFO] running testing-ghgl-status-jbe ..."
echo "========================================"
cd ${TSTDST}
for DDD in $(find * -maxdepth 0 -type d | grep -v "vlpprs_${HST}"); do
	cd $DDD &> /dev/null

	get-status "/usr/bin/git"
	cd ..
done

printf "${COLOR_SET}"
if [ ${#report[@]} -gt 0 ]; then
	echo
	for (( j=0; j<${#report[@]}; j++ )); do
		# echo "*** ${report[$j]} ***"
		echo "*** ${report[$j]} ***" | tee -a $TESTING_STATUS_REPORTS
	done
else
	echo
	echo "*** [REPORT] No action required ***"
fi
printf "${COLOR_RESET}"

cd ${CURRDIR}

echo ""

