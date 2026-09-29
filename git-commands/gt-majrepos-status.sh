#! /usr/bin/env bash
# filename: gt-status.sh
# descpt: git-status to all git repositories
# 20241216: store output of cmd into array instead of external file
# 20241218: read output of cmd directly into array, no more need to run cmd twice
#           c-style for loop
# 20250301: correct output messaging
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

COLOR_SET="\e[1;92m"
COLOR_RESET="\e[0m"
CURRDIR=$PWD

unset msg
unset report
unset output
report=()
> $GT_STATUS_REPORTS

get_status() {
	cmd="$1"
	output=()
	readarray -t -O ${#output[@]} output < <(${cmd} status)
	echo "${output[@]}" | grep -i "git push\|untracked\|modified\|deleted" > /dev/null

	if [[ $? -ne 0 ]]; then
		printf "[i] checking git status in ${DDD} ..."
		printf " no action required\n"
	else
		printf -- "---\n"
		printf "${COLOR_SET}"
		msg=$(echo -e "[REPORT] checking git status in ${DDD} ... NEED TO ADD and/or COMMIT\n")
		echo -e "$msg"
		printf "${COLOR_RESET}"

		readarray -t -O "${#report[@]}" report < <(echo -e "$msg")

		for (( i=0; i<${#output[@]}; i++ )); do
			echo -e ">\t${output[$i]}"
		done
		printf -- "---\n"
	fi
}

printf "========================================\n"
printf "[i] running gt-status ...\n"
printf "========================================\n"
cd ~/majstaf/${HST}git/
for DDD in $(find * -maxdepth 0 -type d | grep -v "vlpprs_${HST}"); do
	cd "$DDD" &> /dev/null

	get_status "/usr/bin/git"
	cd ..
done

# volpejpers
DDD="vlpprs_${HST}"
VOLGITDIR="${HOME}/majstaf/${HST}git/vlpprs_${HST}"
VOLWORKTREE="${HOME}/majstaf/majvolpejpers"
get_status "/usr/bin/git --git-dir=${VOLGITDIR} --work-tree=${VOLWORKTREE}"

printf "${COLOR_SET}"
if [ ${#report[@]} -gt 0 ]; then
	printf "\n"
	for (( j=0; j<${#report[@]}; j++ )); do
		# printf "*** ${report[$j]} ***\n"
		printf "*** ${report[$j]} ***\n" | tee -a $GT_STATUS_REPORTS
	done
else
	printf "\n"
	printf "*** [REPORT] No action required ***\n"
fi
printf "${COLOR_RESET}"

cd "${CURRDIR}"

printf "\n"

