#! /usr/bin/env bash

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	echo -e "[E] -- no filename as argument\n"
	exit
else
	FNAME="$ARG"
fi

if [ ! -f ${FNAME} ]; then
	echo -e "[E] -- no such file\n"
	exit
fi

NEW_FNAME=$(echo ${FNAME} | sed 's/ \././' | tr '-' '_')
echo "[i] -- renaming ${FNAME} into ${NEW_FNAME} ..."
read -r -p "[?] OK?"

mv -v ${FNAME} ${NEW_FNAME}

echo -e "[i] done\n"

