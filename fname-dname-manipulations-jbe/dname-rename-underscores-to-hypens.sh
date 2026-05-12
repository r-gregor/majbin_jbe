#! /bin/bash
# fname: dname-rename-underscores-to-hypens
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	echo -e "[ERROR] -- no dirname as argument\n"
	exit
else
	DNAME="$ARG"
fi

if [ ! -d "${DNAME}" ]; then
	echo -e "[ERROR] -- no such directory\n"
	exit
fi

NEW_DNAME=$(echo "${DNAME}" | sed 's/ \././' | tr '_' '-')
echo "[INFO] -- renaming '${DNAME}' into '${NEW_DNAME}' ..."
read -p "OK?"

printf "[INFO] "
mv -v "${DNAME}" "${NEW_DNAME}"
printf  "\n"

