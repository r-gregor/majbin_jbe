#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	path=$(realpath $1)
else
	path=$(realpath "*")
fi

if [[ ${path} != *"majstaf/coding"* ]]; then
	read -p "NOT in ~/majstaf/coding/... !! Continue? "
fi

for FFF in $(find ${path} -type f); do file $FFF | /usr/bin/grep 'ELF'; done | cut -d':' -f1

