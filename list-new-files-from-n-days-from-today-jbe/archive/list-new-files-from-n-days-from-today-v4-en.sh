#! /usr/bin/env bash
# fname: list-new-files-from-n-days-from-today-en.sh
# 20260731 v1
# 20260809 v2 refine find command to prune (not desend into unwanted drectories
# 20260810 v3 add options to select path and days difference
# last 20260810
# ---

usage() {
	printf "\n\tUsage: <scriptname> <path (optional)> <days difference to go back from today>\n"
	printf "\n\t                    if <path> nor given --> path is current directory (\".\")\n\n"
}

list_new_files() {
	find "${PTH}" \( \
		-path '**/.config*' \
		-o -path '**/engit' \
		-o -path '**/.*' \
		-o -path '**/snap' \
		-o -path '**/_NERAZPOREJENO' \) \
	-prune -o -newerct "${newdate}" -type f -print
}

YR=$(date "+%Y")
MN=$(date "+%m")
DY=$(date "+%d")


if [ $# -eq 2 ]; then
	PTH="${1}"
	ddiff=${2}
elif [ $# -eq 1 ]; then
	PTH='.'
	ddiff=${1}
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

# test
# echo "new_DY: ${new_DY}"
# read -p "OK?"

if [ $new_DY -le 0 ]; then
	printf "[ERROR] The days difference is to big\n"
	exit 1
fi

newdate=$(printf "%4d%02d%02d\n" "${YR}" "${new_MN}" "${new_DY}")

# test
# echo "newdate: ${newdate}"
# read -p "OK?"
list_new_files
