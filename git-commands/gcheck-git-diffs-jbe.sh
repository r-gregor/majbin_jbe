#! /usr/bin/env bash
# filename: check-git-diffs-jbe
# 20241106 v2 jbe
# 20241106 v3 mdb
# 20250417 v4 mdb
# 20260305 v5 mdb
# last: 20260305
# ---

HST="jbe"
src_path=${HOME}/majstaf
dst_path=${HOME}/majstaf/${HST}git

if [ $# -eq 1 ]; then
	src=${1}
	dst=${1}_${HST}
elif [ $# -eq 2 ]; then
	src=$1
	dst=$2
else
	src="majbin"
	dst="majbin_${HST}"
fi

export majfjls_src=${src_path}/${src}
export majfjls_dst=${dst_path}/${dst}

# test
echo "[INFO] majfjls_src: ${majfjls_src}"
echo "[INFO] majfjls_dst: ${majfjls_dst}"
read -p "Continue?"

if [ ! -d ${majfjls_src} ] || [ ! -d ${majfjls_dst} ]; then
	echo -e "[ERROR] No such directories found\n"
	exit
fi

short_src=$(echo ${majfjls_src} | sed "s:${HOME}/majstaf:...:")
short_dst=$(echo ${majfjls_dst} | sed "s:${HOME}/majstaf:...:")

echo "[INFO] Checking diffs in \"${short_src}\" and \"${short_dst}\""

# fjls=($(diff -q ${majfjls_src}/ ${majfjls_dst}/ | grep -iv "common\|differ\|backup" | grep -iv '\.git' | grep -iv '\.txt' | cut -d' ' -f3- | sed 's/: //' | fzf -m --reverse))
# check=($(diff -qr ${majfjls_src} ${majfjls_dst} | grep -iv "common\|differ\|backup" | grep -iv '\.git' | grep -iv 'jbegit' | cut -d' ' -f3- | sed -e 's/\/: /\//' -e 's/: /\//'))
check=($(diff -qr ${majfjls_src} ${majfjls_dst} \
	| grep -i "only" \
	| grep -iv "${HST}git\|backup\|pycache\|common\|differ" \
	| grep -iv '\.git' \
	| cut -d' ' -f3- \
	| sed -e 's/\/: /\//' -e 's/: /\//'))

if [ "x${check[0]}" == "x" ]; then
	echo "[INFO] No files found"
	echo -e "---\n"
	exit
fi

fjls=$(for FFF in $(echo ${check[@]}); do echo $FFF; done | fzf -m --reverse)


if [ "x${fjls[0]}" == "x" ]; then
	echo "[INFO] No files found/selected"
	echo -e "---\n"
	exit
fi

SRC=$(echo ${majfjls_src} | sed "s:${HOME}/majstaf/::")
DST=$(echo ${majfjls_dst} | sed "s:${HOME}/majstaf/::")

echo -e "[INFO] Files to be copied from [${SRC}] to [${DST}]:"
i=0
for FJL in ${fjls[@]}; do
	((i++))
	printf "\t%2d - %s\n" ${i} "$(echo ${FJL} | sed -e "s:${majfjls_src}::" | sed "s:^/::")"
done
echo ""

read -p "[y/Y] to procede [Any other key to quit] " choice

if [ $choice = "y" ] || [ $choice = "Y" ]; then
	for FJL in ${fjls[@]}; do
		cp -irv ${FJL} $(echo ${majfjls_dst} | sed 's/\/$//')/$(echo ${FJL} | sed "s:${majfjls_src}::" | sed "s:^/::")
	done
	echo "[INFO] done"
	echo "---"
else
	echo "[INFO] quit"
	echo -e "---\n"
	exit
fi

