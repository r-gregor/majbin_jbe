#! /usr/bin/env bash
# filename: check4emptyd.sh
# descpt: check for empty directories
# 20260928
# last: 20260928
# ---

if [ $# -ne 1 ]; then
	curdir="."
else
	curdir="$1"
fi

testd=$(realpath ${curdir})

if [ "$(ls -A ${testd})" ]; then
	echo "[INFO] *** ${testd} is NOT empty! ***"
else
	echo "[INFO] ${testd} is empty"
fi

