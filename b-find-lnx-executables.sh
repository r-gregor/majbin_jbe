#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	path=$(realpath $1)
else
	path="*"
fi

for FFF in $(find ${path} -type f); do file $FFF |  /usr/bin/grep --color 'ELF' | cut -d':' -f1; done

