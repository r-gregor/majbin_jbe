#! /usr/bin/env bash
# fname: fnd-python-files-by-time.sh
# descpt: find python files sorted by date
# 20260514
# ---

# === MAIN ===
clear
if [ $# -eq 1 ]; then
	LCT="$1"
else
	LCT="$PWD"
fi

if [ ! -e "${LCT}" ]; then
	printf "[e] no such path: '%s'\n\n" "${LCT}"
	exit 1
fi
	

clear
printf "[i] finding [ python ... txt ] files, sorted by date ...\n"
printf "[i] serch start location is: \n\t'%s'\n" "${LCT}"
	
# command:
find ${LCT} -type f -iname "*python*" -o -iname "ptn*" -exec ls -lgG --time-style=long-iso {} \; 2>/dev/null | cut -d' ' -f4- | sort -nr
if [ $? -ne 0 ]; then
	printf "[e] something went wrong\n\n"
	exit 1
fi

printf "[i] done\n\n"

