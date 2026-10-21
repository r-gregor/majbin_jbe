#! /bin/bash
# fname: listulb2.sh
# descpt: display all soft-linked scriptd in ~/.local/bin
# 20261001
# last: 20261001
# ---

clear
printf "List of \"soft-linked\" scripts on ${HOME}/.local/bin:\n\n"

for slfname in $(find ${HOME}/.local/bin -type l)
	do ls -lgG "${slfname}" | awk '{printf "%s;%s\n", $7, $9}'
done

printf "\n"


