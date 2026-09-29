#! /usr/bin/env bash
# filename: gt-testpush.sh
# descpt: git-test-push to all git repositories to check if PULL from rmeotes is needed
# 20241216: store output of cmd into array instead of external file
# 20241218: read output of cmd directly into array, no more need to run cmd twice
#           c-style for loop
# 20250301: correct output messaging
# 20260818: added codeberg.org/r-gregor remote
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

# COLOR_SET="\e[1;94m"
# COLOR_SET="\e[1;34m"
COLOR_SET="\e[1;38;5;75m"
COLOR_RESET="\e[0m"
DEST=${HOME}/majstaf/${HST}git/
unset output
unset report

output=()
report=()
> $GT_TPUSH_REPORTS

CURRDIR="$PWD"
cd "${DEST}" || exit 1

echo "========================================"
echo "[INFO] running gt-majrepos-testpush ..."
echo "========================================"
for DDD in $(find * -maxdepth 0 -type d); do
	printf "${COLOR_SET}"
	echo "***    git testpush in ${DDD} ... ***"
	printf "${COLOR_RESET}"
	cd "$DDD" &>/dev/null
	# readarray -t output < <(~/.local/bin/ghgl-testpush)
	readarray -t output < <(~/.local/bin/gt-all-remotes-testpush )
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
		echo "*** ${report[$j]} ***" | tee -a $GT_TPUSH_REPORTS
	done
else
	echo
	echo "*** [REPORT] No action required ***"
fi
printf "${COLOR_RESET}"

cd "${CURRDIR}" || exit 1

echo ""

