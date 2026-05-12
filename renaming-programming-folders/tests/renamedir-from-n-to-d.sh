#! /usr/bin/env bash
#  renamedir-from-en-to-d.sh

if [ $# -ne 1 ]; then
	echo -e "Usage: $0 <dirname>\n"
	exit
else
	dname1=$1
fi

if [ ! -d ${dname1} ]; then
	echo -e "[ERROR]: There is NO ${dname1} directory\n"
	exit
fi

dname2=$(echo ${dname1} | sed 's/\(^.\)n_\(.*\)/\1d_\2/')

if [ "${dname1}" == "${dname2}" ]; then
	echo "[INFO]: Old and New dirname are the same"
	echo -e "[INFO]: NO renaming\n"
	exit
fi

mv -v ${dname1} ${dname2}

