#! /usr/bin/env bash
# fname: search-by1-or-more.sh
# descpt: search file by part of filename in files list (1 param) or in selected files list (2 params, or more)
# 20261002 v1
# last: 
# ---

if [ $# -lt 1 ]; then
	printf "[E] usage: $0 <search param1> <search param2>:\n"
	printf "\t<search param1> = 1st pattern --> list of filesi\n"
	printf "\t<search param2> = 2nd pattern search in list of files.\n"
	exit 1
fi

if [ $# -eq 1 ]; then
	patt1="$1"
	# ls | xargs -I{} grep --color -inH -s ${patt1} {}
	ls | grep --color -i "${patt1}"
else
	search_cmd="ls | xargs -I{} grep -ils ${patt1} {}"

	for ((i=2; i<=$#-1; ++i)); do
		search_cmd="$search_cmd | xargs -I{} grep -ils ${!i} {}"
	done

	search_cmd="${search_cmd} | xargs -I{} grep --color -inH -s ${!i} {}"
fi

eval "$search_cmd"

