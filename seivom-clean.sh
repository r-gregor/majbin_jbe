#! /usr/bin/env bash
# 20250328 v1 d

CURRDIR="${HOME}/majstaf/majmedia/Seivom"
unset dirlist

if [ ! $PWD == ${CURRDIR} ]; then
	echo -e "[E] current dir must be: ${CURRDIR}\n"
	exit
fi

dirlist=()
# readarray -t -O "${#dirlist[@]}" dirlist < <(find * -maxdepth 0 -type d -not -name "_NOVO")
readarray -t dirlist < <(find * -maxdepth 0 -type d -not -name "_NOVO")

if [ ${#dirlist[@]} -eq 0 ]; then
	echo -e "[E] no directories to remove\n"
	exit
fi

echo "[i] diractories to be removed:"
for (( j=0; j<${#dirlist[@]}; j++)); do
	echo "${dirlist[j]}"
done

read -r -p "[?] -- OK? "

for (( j=0; j<${#dirlist[@]}; j++)); do
	rm -rv ${dirlist[j]}
done
