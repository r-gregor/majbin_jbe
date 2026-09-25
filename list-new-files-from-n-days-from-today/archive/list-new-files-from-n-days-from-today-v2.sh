#! /usr/bin/env bash
# fname: list-new-files-from-n-days-from-today.sh
# v1_20260731
# last 20260731
# ---

usage() {
	printf "\n\tUsage: list-new-files-from-n-days-from-today <days differenc to go back from today>\n\n"
}


YR=$(date "+%Y")
MN=$(date "+%m")
DY=$(date "+%d")

if [ $# -ne 1 ]; then
	usage
	printf "\n"
	exit 1
else
	ddiff=${1}
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

# -newermt: m - modification time
# -newerBt: B - birth time
# -newerct: c - inode change time
find ${HOME}/* \( \
	   -path $HOME/**/.git \
	-o -path $HOME/**/.cache \
	-o -path $HOME/**/.mnt \
	-o -path $HOME/**/engit \
	-o -path $HOME/**/mozilla \) \
-prune -o -newerct "${newdate}" -type f -print

