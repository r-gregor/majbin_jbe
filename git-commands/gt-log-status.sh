#! /usr/bin/env bash
# filename: gt-log-status.sh
# descpt: Git-log fancy status report
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

# for myopt in raw numstat shortstat dirstat summary name-only name-status check; do
# 	printf -e "*** git log --${myopt} ***\n"
# 	git log --${myopt} | head -n 15
# 	printf  "---\n"
# done

if [ -d .git ] || [ -f HEAD ]; then
	/usr/bin/git log --name-status
else
	printf "[E] NOT a git repository\n"
	exit
fi

