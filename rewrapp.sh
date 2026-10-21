#!/bin/bash
#! /usr/bin/env bash
# fname: rewrapp.sh
# descpt: converts documnet to linux lineendins format (dos2unix)
# 20261021
# last: 20261021
# ---


# === GLOBALS ===
unset FAJL

# === MAIN ===
clear

if [ ! "${1}" ]; then
	printf "[e] usage: rewrapp <filename>\n\n"
	exit 1
fi

FAJL="${1}"

if [ ! -f "${FAJL}" ]; then
	printf "[e] no such file: '%s'\n\n" "${FAJL}"
	exit 1
fi

dos2unix "${FAJL}"

FAJL_tmp="tmp_${FAJL}"
printf "fmt --width=110 -s ${FAJL}\n >> ${FAJL_tmp}\n"
fmt --width=110 -s "${FAJL}" >> "${FAJL_tmp}"

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

