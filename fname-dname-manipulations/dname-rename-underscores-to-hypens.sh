#! /bin/bash
# fname: dname-rename-underscores-to-hypens
# descpt: rename directory from underscores to hypens
# 20226031
# last: 20260331
# ---

# === GLOBALS ===
ARG="$@"

# === MAIN ===
if [ "${ARG}" = "" ]; then
	printf "[e] no dirname as argument\n\n"
	exit 1
else
	DNAME="$ARG"
fi

if [ ! -d "${DNAME}" ]; then
	printf "[e] no such directory\n\n"
	exit 1
fi

NEW_DNAME=$(echo "${DNAME}" | sed 's/ \././' | tr '_' '-')
printf "[i] renaming '${DNAME}' into '${NEW_DNAME}' ...\n"
read -p "[?] ok?"

printf "[i] "
mv -v "${DNAME}" "${NEW_DNAME}"
printf  "\n"

