#! /usr/bin/env bash

### Name:	vmf.sh (vimfind)
# -e flag for exact match

if [ $# -eq 1 ]; then
	PTH=$1
	cd $PTH
fi

# xargs '-r' flag: if no arguments to xargs DO NOT run command
find . | fzf -e | xargs -r -o vim

