#! /usr/bin/env bash
# fname: is-it-in-svm.sh
# descpt: check if movie in _DSVM.txt
# 20261009 v1
# last: 20261009
# ---


PTH="${HOME}/majstaf/majmedia/_DSVM.txt"


if [ $# -ne 1 ]; then
	echo -e "[E] must supply a part of movie name\n\n"
	exit 1
else
	PTRN=$1
fi

grep -i "$PTRN" $PTH
printf "\n"

