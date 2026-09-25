#! /usr/bin/env bash
# filename: gt-testing-testpush.sh
# descpt: git-test-push to all testing repositories to check if PULL from rmeotes is needed
# 20241216: store output of cmd into array instead of external file
# 20241218: read output of cmd directly into array, no more need to run cmd twice
#           c-style for loop
# 20250301: correct output messaging
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

# COLOR_SET="\e[1;94m"
COLOR_SET="\e[1;38;5;75m"
COLOR_RESET="\e[0m"
DEST=${HOME}/majstaf/coding2/testing

unset output
unset report

output=()
report=()
> $TESTING_TPUSH_REPORTS

CURRDIR=$PWD
cd ${DEST}

echo "============================================"
echo "[INFO] running gt-testing-testpush ..."
echo "============================================"
for DDD in $(ls -d *); do
	printf "${COLOR_SET}"
	echo "***    git testpush in ${DDD} ... ***"
	printf "${COLOR_RESET}"
	cd "$DDD" &>/dev/null
	readarray -t output < <(~/.local/bin/gt-all-remotes-testpush)
	for (( i=0; i<${#output[@]}; i++)); do
		if [[ "${output[$i]}" =~ "PULL" ]]; then
			msg="$(echo -e "[REPORT] git testpush in: ${DDD} ... NEED TO PULL FROM REMOTE")"
			readarray -t -O "${#report[@]}" report < <(echo -e "$msg")
			echo -e "${output[$i]}"
			break
		else
			 echo -e "${output[$i]}"
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

cd "${CURRDIR}"

echo ""

