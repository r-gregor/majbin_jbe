#! /usr/bin/env bash

place="$HOME/.local/bin"

N=0
for FFF1 in ${place}/*; do
	SF=${#FFF1}
	if [ ${SF} -gt $N ];then
		N=${SF}
		fjl=$FFF1
	fi
done

for FFF2 in $(find ${place}/ -type l); do printf "%-*s\n" "${N}" "$FFF2" | cut -d'/' -f6; done | sort | column -c $(tput cols)

