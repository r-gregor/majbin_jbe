#! /usr/bin/env bash
# fname: list-new-files-from-n-days-from-today-jbe.sh
# 20260731 v1
# 20260809 v2 refine find command to prune (not desend into unwanted drectories
# 20260810 v3 add options to select path and days difference
# 20260810 v4 put find command into function
# 20260810 v5 daysdiff from 1st positional parameter, and optional path from 2nd
# last 20260810
# ---

usage() {
	printf "\n\tUsage: <scriptname> <days difference to go back from today> <path (optional)>\n"
	printf "\n\t                    if <path> nor given --> path is current directory (\".\")\n\n"
}

list_new_files() {
	find "${PTH}" \( \
		-path '**/.config*' \
		-o -path '**/jbegit' \
		-o -path '**/.*' \
		-o -path '**/snap' \
		-o -path '**/_NERAZPOREJENO' \) \
	-prune -o -newerct "${newdate}" -type f -print
}

YR=$(date "+%Y")
MN=$(date "+%m")
DY=$(date "+%d")

if [ $# -eq 2 ]; then
	ddiff=${1}
	PTH="${2}"
elif [ $# -eq 1 ]; then
	ddiff=${1}
	PTH='.'
else
	usage
	printf "\n"
	exit 1
fi

if [ ! -d "${PTH}" ]; then
	printf "[ERROR] no such directory: '%s'\n\n" "${PTH}"
	exit 1
fi

new_DY=$(( DY - ddiff ))
new_MN=${MN//0/}

if [ $new_DY -le 0 ]; then
	printf "[ERROR] The days difference is to big\n"
	exit 1
fi

newdate=$(printf "%4d%02d%02d\n" "${YR}" "${new_MN}" "${new_DY}")

# MAIN
list_new_files

