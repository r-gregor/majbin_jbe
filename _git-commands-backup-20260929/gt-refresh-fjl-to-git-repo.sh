#! /usr/bin/env bash
# filename: gt-refresh-fjl-to-git-repo.sh
# descpt: git refresh/update file/dir from src to git-repository
# 20260921
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

if [ $# -ne 1 ]; then
	echo -e "Usage: $0 <file_name>\n\n"
	exit 1
else
	fname="$1"
fi

curdir="$(basename $PWD)"
destdir="$(echo $PWD | sed "s:majstaf/\(.*\):majstaf/${HST}git/\1_${HST}:" | sed "s:\.config:majstaf/${HST}git/dotfiles_${HST}/.config:")"
echo"$destdir" 

read -p "cp -i ./${fname} ${destdir}/${fname} ?"
cp -v ./"${fname}" "${destdir}/${fname}"

