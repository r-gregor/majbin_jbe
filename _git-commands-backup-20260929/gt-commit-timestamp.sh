#! /usr/bin/env bash
# filename: gt-commit-timestamp.sh
# descpt: git-commit staged files/dirs with timestamp
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

cmd() {
	/usr/bin/git commit "$@"
}

if [ $# -eq 1 ]; then
	if [ $1 == "-a" ]; then
		echo -n "/usr/bin/git commit -a ... "
		read -p "OK?"
		cmd -a
		exit
	else
		msg="$1"
	fi
else
	msg="update"
fi

tmpstmp="$(date +"%Y%m%d_%H%M")_${HST}"
desc="$msg ${tmpstmp}"

echo -n "/usr/bin/git commit -m \"$desc\" ... "
read -p "OK?"
cmd -m "$desc"

