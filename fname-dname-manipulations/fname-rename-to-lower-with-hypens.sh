#! /usr/bin/env bash
# fname: fname-rename-to-lower-with-hypens
# 20260331
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	printf "[E] no filename as argument\n"
	exit
else
	FNAME=$ARG
fi

if [ ! -f "${FNAME}" ]; then
	printf "[E] no such file\n"
	exit
fi

NEW_FNAME=$(echo "${FNAME}" |  tr '[:upper:]' '[:lower:]' | sed -e 's/: */_/g' -e 's/,//g' -e 's/ \././g' -e 's/(//' -e 's/)//' | tr ' ' '-')
printf "[i] renaming:\n'${FNAME}' ... to\n'${NEW_FNAME}'\n"
read -r -p "[?] [INPUT] OK?"
printf "[i] "
mv -v "${FNAME}" "${NEW_FNAME}"
printf "\n"

