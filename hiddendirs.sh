#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	gCurrDir=$(realpath $1)
else
	gCurrDir=$(realpath $PWD)
fi

cd ${gCurrDir}; for FFF in $(sudo find $PWD -maxdepth 1 -type d -name '.*'); do echo ${FFF##*/}; done | xargs sudo du -sh --total | sort -hr

