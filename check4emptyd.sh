#! /usr/bin/env bash

if [ $# -ne 1 ]; then
	curdir="."
else
	curdir="$1"
fi

testd=$(realpath ${curdir})

if [ "$(ls -A ${testd})" ]; then
	echo "[i] ${testd} is NOT empty"
else
	echo "[i] ${testd} is empty"
fi

