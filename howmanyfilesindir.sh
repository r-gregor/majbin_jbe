#! /usr/bin/env bash

# set IFS to newline '\n'
IFS=$'\n'

for DDD in $(find * -maxdepth 0 -type d); do echo -en $(find "$DDD" -type f | wc -l); echo -en "\t"; echo -e "$DDD"; done | sort -nr
# for DDD in $(find * -maxdepth 1 -type d); do echo -e "$(find $DDD/ -type f | wc -l)\t$DDD"; done | sort -nr

# set IFS to orginal ' \t\n'
IFS=$' \t\n'

