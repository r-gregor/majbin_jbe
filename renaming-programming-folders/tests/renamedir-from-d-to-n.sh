#! /usr/bin/env bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 <dirname>"
	exit
else
	dname1=$1
fi

if [ ! -d ${dname1} ]; then
	echo -e "[ERROR]: There is NO ${dname1} directory\n"
	exit
fi

dname2=$(echo ${dname1} | sed 's/\(^.\)d_\(.*\)/\1n_\2/')

if [ "${dname1}" == "${dname2}" ]; then
	echo "[INFO]: Old and New dirname are the same"
	echo -e "[INFO]: NO renaming\n"
	exit
fi

mv -v ${dname1} ${dname2}

