#! /usr/bin/env bash
# fname: slistulb.sh
# descpt: display a list of softlinked commands in '~/.local/bin/' in ls-columns style
# 20261002 v1
# last: 
# ---

place="$HOME/.local/bin"

N=0
for FFF1 in "${place}"/*; do
	SF="${#FFF1}"
	if [ "${SF}" -gt "$N" ];then
		N="${SF}"
		fjl="${FFF1}"
	fi
done

for FFF2 in $(find "${place}"/ -type l); do printf "%-*s\n" "${N}" "${FFF2}" | cut -d'/' -f6; done | sort | column -c $(tput cols)

