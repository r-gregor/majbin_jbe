#! /usr/bin/env bash
# filename: gt-log-status.sh
# descpt: Git-log fancy status report
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

# for myopt in raw numstat shortstat dirstat summary name-only name-status check; do
# 	echo -e "*** git log --${myopt} ***"
# 	git log --${myopt} | head -n 15
# 	echo -e "---\n"
# done

if [ -d .git ] || [ -f HEAD ]; then
	/usr/bin/git log --name-status
else
	echo "NOT a git repository!!"
	exit
fi

