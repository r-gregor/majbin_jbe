#!/usr/bin/env bash
# fname: contains.sh
# descpt: Checks if any file in currdir/sundirs/... contains URL at the top
# 20210125 v2: added lines count to echo if no files found or to echo how many file(s) found
# last: 20210125
# ---

# timestamp
function tms() {
	echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}

# check the number of parameters
if [ $# -ne 1 ]; then
	tms; echo -e "Only ONE parameter allowed!\nUsage:\n\t$(basename $0) <URL, or KeyWord>\n"
	exit
fi

my_URL=$1

# Start
tms; echo "Looking for file with URL: $my_URL ..."

function mycmd() {
	tmpf=$(mktemp)
	# ls $PWD | xargs -IS grep -s --color -Hn $my_URL S | tee $tmpf
	# \ls $PWD | xargs -IS grep -s -Hn $my_URL S > $tmpf
	find "$PWD" -type f -iname "*.txt" | xargs -I{} grep -s -Hn "$my_URL" {} > "$tmpf"
	num=$(cat "$tmpf" | wc -l)
	if [ "$num" -eq 0 ]; then
		tms; echo "No files with that URL found!"
	else
		tms; echo "${num} file(s) found:"
		cat "$tmpf"
		echo
	fi
}

#run command ...
mycmd

rm "$tmpf"
tms; echo "Done."

