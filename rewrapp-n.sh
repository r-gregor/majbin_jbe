#!/bin/bash
#! /usr/bin/env bash
# fname: rewrapp-n.sh
# descpt: converts documnet to linux lineendins format (dos2unix) and rewraps paragraphs to n-ciahrs width
# 20261021
# last: 20261021
# ---


# === GLOBALS ===
unset FAJL

# === MAIN ===
clear

if [ $# -ne 2 ]; then
	printf "\n"
	printf "[e] usage: rewrapp-n <filename> [n]\n"
	printf "           filename ... file to rewrap\n"
	printf "           n .......... number of chars per line\n"
	printf "\n\n"
	exit 1
fi

FAJL="${1}"
CHRSPLINE="${2}"

if [ ! -f "${FAJL}" ]; then
	printf "[e] no such file: '%s'\n\n" "${FAJL}"
	exit 1
fi

dos2unix "${FAJL}"

FAJL_tmp="tmp_${FAJL}"
printf  "[i] fmt --width=${CHRSPLINE} -s ${FAJL} >> ${FAJL_tmp}\n"
fmt --width="${CHRSPLINE}" -s "${FAJL}" >> "${FAJL_tmp}"

printf -- "---\n"

cp -v "${FAJL}" ~/.tmp/
printf "[i] '%s' copied to ~/.tmp/\n" "${FAJL}"

printf -- "---\n"

rm -v "${FAJL}"
mv -v "${FAJL_tmp}" "${FAJL}"
printf "[i] '%s' renamed to: '%s'\n" "${FAJL_tmp}" "${FAJL}"

printf -- "---\n"

printf "[i] removing temporary file ...\n"
rm -i ~/.tmp/"${FAJL}"
printf "[i] done\n"
printf -- "---\n\n"


