#! /bin/bash
# fname: fnd-txt-latest-files-by-time.sh
# descpt: find latest *.txt files sorted by time
# v1_20260514
#---

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
printf "[i] finding [ latest ... txt ] files, sorted by date ...\n"
printf "[i] serch start location is: \n\t'%s'\n" "${LCT}"
	
# command:
find ${LCT} -type f -iname "*txt" -exec ls -lgG --time-style=long-iso {} \; 2>/dev/null | cut -d' ' -f4- | sort -nr
if [ $? -ne 0 ]; then
	printf "[e] something went wrong\n\n"
	exit 1
fi

printf "[i] done\n\n"

