#! /usr/bin/env bash
# fname: dname-rename-to-underscores-with-hypens
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	printf "[E] -- no dirname as argument\n"
	exit
else
	DNAME="$ARG"
fi

if [ ! -d "${DNAME}" ]; then
	printf "[E] -- no such directory\n"
	exit
fi

NEW_DNAME=$(echo "${DNAME}" | sed 's/ \././' | tr '_' '-')
printf "[i] -- renaming ${DNAME} into ${NEW_DNAME} ...\n"
read -r -p "[?] OK?"

printf "[i] "
mv -v "${DNAME}" "${NEW_DNAME}"
printf  "\n"

