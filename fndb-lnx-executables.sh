#! /usr/bin/env bash
# fname: fndb-lnx-executables.sh
# descpt: find linux executables
# 20260929 v1
# last: 20260929
# ---


if [ $# -eq 1 ]; then
	path=$(realpath "$1")
else
	path=$(realpath "*")
fi

if [[ ${path} != *"majstaf/coding2"* ]]; then
	read -r -p "[i] NOT in ~/majstaf/coding2/... !! Continue? "
fi

printf "[i] searching for lnx-executables in '%s' ...\n" "${path}"
for FFF in $(find "${path}" -type f); do file "$FFF" | /usr/bin/grep -i 'ELF'; done | cut -d':' -f1

