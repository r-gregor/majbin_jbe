#! /usr/bin/env bash
# filename: grefresh-fjl-to-git-repo
# last chanfed: 20250406

if [ $# -ne 1 ]; then
	echo -e "Usage: $0 <file_name>\n\n"
	exit
else
	fname=$1
	usr=jbe
fi

curdir="$(basename $PWD)"
destdir="$(echo $PWD | sed "s:majstaf/\(.*\):majstaf/${usr}git/\1_${usr}:" | sed "s:\.config:majstaf/${usr}git/dotfiles_${usr}/.config:")"
echo $destdir

read -p "cp -i ./${fname} ${destdir}/${fname} ?"
cp -v ./${fname} ${destdir}/${fname}

