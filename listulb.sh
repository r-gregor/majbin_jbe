#! /usr/bin/env bash
# fname: listulb.sh
# descpt: display all soft-linked scriptd in ~/.local/bin
# change: 20150310
# change: 20200308:  - display only basename of ${HOME}/.local/bin/[filename]
#                    - sorted output by ${HOME}/.local/bin/[filename]
# 20261001
# last: 20261001
# ---

clear
printf "List of \"soft-linked\" scripts in ${HOME}/.local/bin:\n\n"

for slfname in $(find "${HOME}/.local/bin" -type l); do
	F1=$(basename "${slfname}")
	F2=$(ls -lgG "${slfname}" | awk '{print $9}')
    printf "%-40s%s\n" $F1 $F2 | tr ' ' '.'
done | sort

printf "\n"

