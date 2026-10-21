#! /usr/bin/env bash
# fname: fname-rename-to-lower-with-hypens
# descpt: rename file to lower with hypens
# 20260331
# last: 20260331
# ---

# === GLOBALS ===
ARG="$@"

# === MAIN ===
if [ "${ARG}" = "" ]; then
	printf "[e] no filename as argument\n\n"
	exit 1
else
	FNAME="$ARG"
fi

if [ ! -f "${FNAME}" ]; then
	printf "[e] no such file\n\n"
	exit 1
fi

NEW_FNAME=$(echo "${FNAME}" |  tr '[:upper:]' '[:lower:]' | sed -e 's/: */_/g' -e 's/,//g' -e 's/ \././g' -e 's/(//' -e 's/)//' | tr ' ' '-')
printf "[i] renaming:\n'${FNAME}' ... to\n'${NEW_FNAME}'\n"
read -r -p "[?] ok?"
printf "[i] "
mv -v "${FNAME}" "${NEW_FNAME}"
printf "\n"

