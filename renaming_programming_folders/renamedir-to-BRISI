#! /usr/bin/env bash
#  renamedir-to-BRISI.sh

if [ $# -ne 1 ]; then
	echo "Usage: $0 <dirname>"
	exit
else
	dname1=$1
fi

if [ ! -d ${dname1} ]; then
	echo "[ERROR]: There is NO ${dname1} directory"
	exit
fi

# dname2=$(echo ${dname1} | sed 's/\(^.\)n_\(.*\)/\1d_\2/')
dname2=_BRISI_${dname1}

if [ "${dname1}" == "${dname2}" ]; then
	echo "[INFO]: Old and New dirname are the same"
	echo "[INFO]: NO renaming"
	exit
fi

mv -v ${dname1} ${dname2}

