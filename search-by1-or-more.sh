#! /usr/bin/env bash
# filename: search_by1_or_more.sh

if [ $# -lt 1 ]; then
    echo -e "\nUsage: $0 <search param1> <search patam2:\n"
    echo -e "\t<search param1> = 1st pattern --> list of files."
    echo -e "\t<search param2> = 2nd pattern search in list of files.\n"
    exit
fi

patt1=$1

if [ $# -eq 1 ]; then
    # patt1=$1
    ls | xargs -I{} grep --color -inH -s ${patt1} {}

else
    # echo "$patt1"
    search_cmd="ls | xargs -I{} grep -ils ${patt1} {}"
    # echo "$search_cmd"

    for ((i=2; i<=$#-1; ++i)); do
        # echo "${!i}"
        search_cmd="$search_cmd | xargs -I{} grep -ils ${!i} {}"
    done
    search_cmd="${search_cmd} | xargs -I{} grep --color -inH -s ${!i} {}"
    # echo "$search_cmd"
fi
eval "$search_cmd"
