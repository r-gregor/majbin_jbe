#! /usr/bin/env bash
# filename: gt-all-remotes-testpush.sh
# descpt: Test-push to check if pull from all remotes is needed
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

rmts=( $(git remote) )

COLOR_RED="\e[1;92m"
COLOR_RESET="\e[0m"

for rmt in "${rmts[@]}"
do
	printf -n "[i] git testpush in: $(git remote get-url ${rmt}) ...\n"
	output=$(/usr/bin/git push --dry-run "${rmt}" main 2>&1)
	echo "$output" | grep 'reject\|pull' &> /dev/null
	if [[ $? -eq 0 ]]; then
		printf " ${COLOR_RED} NEED TO PULL FROM REMOTE\n"
		printf "${COLOR_RESET}"
	else
		printf " no action required\n"
	fi
done

