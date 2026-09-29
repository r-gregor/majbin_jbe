#! /usr/bin/env bash
# filename: gt-check-git-diffs.sh
# descpt: Check git-diffs for all files in git-repository with src-files
# 20241106 v2
# 20241106 v3
# 20250417 v4
# 20260305 v5
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

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

export majfjls_src="${src_path}/${src}"
export majfjls_dst="${dst_path}/${dst}"

# test
printf "[i] majfjls_src: ${majfjls_src}\n"
printf "[i] majfjls_dst: ${majfjls_dst}\n"
read -r -p "[?] Continue?"

if [ ! -d "${majfjls_src}" ] || [ ! -d "${majfjls_dst}" ]; then
	printf -e "[E] No such directories found\n\n"
	exit
fi

short_src=$(echo "${majfjls_src}" | sed "s:${HOME}/majstaf:...:")
short_dst=$(echo "${majfjls_dst}" | sed "s:${HOME}/majstaf:...:")

printf "[i] Checking diffs in \"${short_src}\" and \"${short_dst}\"\n"

# fjls=($(diff -q ${majfjls_src}/ ${majfjls_dst}/ | grep -iv "common\|differ\|backup" | grep -iv '\.git' | grep -iv '\.txt' | cut -d' ' -f3- | sed 's/: //' | fzf -m --reverse))
# check=($(diff -qr ${majfjls_src} ${majfjls_dst} | grep -iv "common\|differ\|backup" | grep -iv '\.git' | grep -iv 'jbegit' | cut -d' ' -f3- | sed -e 's/\/: /\//' -e 's/: /\//'))
check=($(diff -qr "${majfjls_src}" "${majfjls_dst}" \
	| grep -i "only" \
	| grep -iv "${HST}git\|backup\|pycache\|common\|differ" \
	| grep -iv '\.git' \
	| cut -d' ' -f3- \
	| sed -e 's/\/: /\//' -e 's/: /\//'))

if [ "${check[0]}" == "" ]; then
	printf "[i] No files found\n"
	printf -- "---\n"
	exit
fi

fjls=$(for FFF in $(echo "${check[@]}"); do echo "$FFF"; done | fzf -m --reverse)


if [ "${fjls[0]}" == "" ]; then
	printf "[i] No files found/selected\n"
	printf -- "---\n"
	exit
fi

SRC=$(echo "${majfjls_src}" | sed "s:${HOME}/majstaf/::")
DST=$(echo "${majfjls_dst}" | sed "s:${HOME}/majstaf/::")

printf "[i] Files to be copied from [${SRC}] to [${DST}]:\n"
i=0
for FJL in "${fjls[@]}"; do
	((i++))
	printf "\t%2d - %s\n" ${i} "$(echo "${FJL}" | sed -e "s:${majfjls_src}::" | sed "s:^/::")"
done
printf "\n"

read -p "[y/Y] to procede [Any other key to quit] " choice

if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
	for FJL in "${fjls[@]}"; do
		cp -irv "${FJL}" $(echo "${majfjls_dst}" | sed 's/\/$//')/$(echo "${FJL} "| sed "s:${majfjls_src}::" | sed "s:^/::")
	done
	printf "[i] done\n"
	printf -- "---\n"
else
	printf "[i] quit\n"
	printf -- "---\n"
	exit
fi

