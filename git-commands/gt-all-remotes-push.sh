#! /usr/bin/env bash
# filename: gt-all-remotes-push.sh
# descpt: PUSH to all remotes
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

rmts=( $(git remote) )

for rmt in "${rmts[@]}"; do
	printf "[i] git PUSH in: $(git remote get-url ${rmt}) ...\n"
	git push ${rmt} main
	printf -- "---\n"
done
printf "\n"

