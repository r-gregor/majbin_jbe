#! /usr/bin/env bash

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	echo -e "[ERROR] -- no filename as argument\n"
	exit
else
	FNAME="$ARG"
fi

if [ ! -f ${FNAME} ]; then
	echo -e "[ERROR] -- no such file\n"
	exit
fi

NEW_FNAME=$(echo ${FNAME} | sed 's/ \././' | tr '-' '_')
echo "[INFO] -- renaming ${FNAME} into ${NEW_FNAME} ..."
read -p "OK?"

mv -v ${FNAME} ${NEW_FNAME}

echo -e "[INFO] done\n"

