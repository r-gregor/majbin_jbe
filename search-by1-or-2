#! /usr/bin/env bash
# filename: search_by1_or_2.sh

if [ $# -gt 2 -o $# -eq 0 ]; then
    echo -e "\nUsage: $0 <search param1> <search patam2:\n"
    echo -e "\t<search param1> = 1st pattern --> list of files."
    echo -e "\t<search param2> = 2nd pattern search in list of files."
    exit
fi

if [ $# -eq 1 ]; then
    patt1=$1
    ls | xargs -I{} grep --color -inH -s ${patt1} {}

else
    patt1=$1
    patt2=$2
    ls | xargs -I{} grep -ils ${patt1} {} | xargs -I{} grep --color -inH -s ${patt2} {}
fi
