#! /usr/bin/env bash
# fname: fndb-win-executables.sh
# descpt: find MS Win executables
# 20260929 v1
# last: 20260929
# ---

if [ $# -eq 1 ]; then
	path=$(realpath "$1")
else
	path=$(realpath "*")
fi

if [[ "${path}" != *"majstaf/coding2"* ]]; then
	read -r -p "[i] NOT in ~/majstaf/coding2/... !! Continue? "
fi

echo "[i] searching for win-executables in '%s' ...\n" "${path}"
for FFF in $(find "${path}" -type f); do file "$FFF" | /usr/bin/grep -i 'PE32'; done | cut -d':' -f1;

