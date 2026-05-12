#! /usr/bin/env bash
# filename: jbegt-testpush
# 20241216: store output of cmd into array instead of external file
# 20241218: c-style for loop
# last change: 20250831

# COLOR_SET="\e[1;94m"
# COLOR_SET="\e[1;34m"
COLOR_SET="\e[1;38;5;75m"
COLOR_RESET="\e[0m"
HST="jbe"
JDEST=${HOME}/majstaf/${HST}git/
unset output
unset report

output=()
report=()
> $TESTING_TPUSH_REPORTS

CURRDIR=$PWD
cd ${JDEST}

echo "========================================"
echo "[INFO] running jbegt_testpush ..."
echo "========================================"
for DDD in $(find * -maxdepth 0 -type d); do
	printf "${COLOR_SET}"
	echo "***    git testpush in ${DDD} ... ***"
	printf "${COLOR_RESET}"
	cd $DDD &>/dev/null
	readarray -t output < <(~/.local/bin/ghgl-testpush-${HST})
	for (( i=0; i<${#output[@]}; i++)); do
		if [[ "${output[$i]}" =~ "PULL" ]]; then
			msg="$(echo -e "[REPORT] git testpush in: ${DDD} ... NEED TO PULL FROM REMOTE")"
			readarray -t -O "${#report[@]}" report < <(echo -e "$msg")
			echo -e ${output[$i]}
			break
		else
			echo -e ${output[$i]}
		fi
	done
	cd ..
done

printf "${COLOR_SET}"
if [ ${#report[@]} -gt 0 ]; then
	echo
	for (( j=0; j<${#report[@]}; j++)); do
		# echo "*** ${report[$j]} ***"
		echo "*** ${report[$j]} ***" | tee -a $TESTING_TPUSH_REPORTS
	done
else
	echo
	echo "*** [REPORT] No action required ***"
fi
printf "${COLOR_RESET}"

cd ${CURRDIR}

echo ""

