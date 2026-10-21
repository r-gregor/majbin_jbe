#! /usr/bin/env bash
# fname: seivom-clean.sh
# descpt: Clean Seivom directory: remove all directories except '_NOVO' and 'APPROVED'
# 20260930 v1
# last: 20260930
# ---

CURRDIR="${HOME}/majstaf/majmedia/Seivom"
unset dirlist

if [ ! "$PWD" == "${CURRDIR}" ]; then
	echo -e "[e] current dir must be: ${CURRDIR}\n"
	exit
fi

dirlist=()
# readarray -t -O "${#dirlist[@]}" dirlist < <(find * -maxdepth 0 -type d -not -name "_NOVO")
readarray -t dirlist < <(find * -maxdepth 0 -type d -not -name "_NOVO" -a -not -name "APPROVED")

if [ "${#dirlist[@]}" -eq 0 ]; then
	echo -e "[e] no directories to remove\n"
	exit
fi

echo "[i] diractories to be removed:"
for (( j=0; j < "${#dirlist[@]}"; j++)); do
	echo "${dirlist[j]}"
done

read -r -p "[?] OK? "

for (( j=0; j < "${#dirlist[@]}"; j++)); do
	# rm -rv ${dirlist[j]}

	printf "test echo: "
	echo "rm -rv ${dirlist[j]}"
done
