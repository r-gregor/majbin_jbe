#! /usr/bin/env bash
# fname: dname-rename-hypens-to-underscores
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	printf "[ERROR] -- no dirname as argument\n"
	exit
else
	DNAME="$ARG"
fi

if [ ! -d "${DNAME}" ]; then
	printf "[ERROR] -- no such directory\n"
	exit
fi

NEW_DNAME=$(echo "${DNAME}" | sed 's/ \././' | tr '-' '_')
printf "[INFO] -- renaming '${DNAME}' into '${NEW_DNAME}' ...\n"
read -p "OK?"

printf "[INFO] "
mv -v "${DNAME}" "${NEW_DNAME}"
printf  "\n"

