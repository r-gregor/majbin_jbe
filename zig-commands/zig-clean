#! /usr/bin/env bash

TARGET=$PWD

OUT="${TARGET}/zig-out"
CCH="${TARGET}/.zig-cache"

if [ ! -d ${OUT} ]; then
	echo -e "[ERROR] no 'zig-out' dir\n"
	exit
fi

echo "Dirs to remove:" 
echo "${OUT}"
echo "${CCH}"
read -p "OK ?"

rm -rv ${OUT} ${CCH}

