#! /usr/bin/env bash


if [ $# -ne 1 ]; then
	echo -e "Usage: remove_all_commented_lines_c [filename.c]\n"
	exit
else
	fname_c=$1
fi

if [ ! -f ${fname_c} ]; then
	echo -e "Filename ${fname_c} does NOT exist!\n"
	exit
fi

sed -e '/^\s*\/\/ /d' -e '/^\s*\//d' -e '/^\s*\*\//d' -e '/^\s*\* /d' ${fname_c}

