#! /bin/bash
# fname: dname-rename-underscores-to-hypens
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	echo -e "[E] -- no dirname as argument\n"
	exit
else
	DNAME="$ARG"
fi

if [ ! -d "${DNAME}" ]; then
	echo -e "[E] -- no such directory\n"
	exit
fi

NEW_DNAME=$(echo "${DNAME}" | sed 's/ \././' | tr '_' '-')
echo "[i] -- renaming '${DNAME}' into '${NEW_DNAME}' ..."
read -r -p "[?] OK?"

printf "[i] "
mv -v "${DNAME}" "${NEW_DNAME}"
printf  "\n"

