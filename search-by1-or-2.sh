#! /usr/bin/env bash
# fname: search-by1-or-2.sh
# descpt: search file by part of filename in files list (1 param) or in selected files list (2 params)
# 20261002 v1
# last: 20261002
# ---

if [ $# -gt 2 -o $# -eq 0 ]; then
	printf "[E] usage: $0 <search param1> <search param2>:\n"
	printf "\t<search param1> = 1st pattern --> list of filesi\n"
	printf "\t<search param2> = 2nd pattern search in list of files.\n"
	exit 1
fi

if [ $# -eq 1 ]; then
	patt1="$1"
	ls | xargs -I{} grep --color -inH -s "${patt1}" {}
else
	patt1="$1"
	patt2="$2"
	ls | xargs -I{} grep  -ils "${patt1}" {} | xargs -I{} grep --color -inH -s "${patt2}" {}
fi

