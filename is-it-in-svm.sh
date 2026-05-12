#! /usr/bin/env bash

PTH="/home/rgregor/majstaf/majmedia/_DSVM.txt"


if [ $# -ne 1 ]; then
	echo -e "[ERROR] must supply a part of movie name\n"
	exit
else
	PTRN=$1
fi

grep -i "$PTRN" $PTH

