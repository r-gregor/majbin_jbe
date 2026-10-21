#! /usr/bin/env bash
# fname: remove-all-commented-lines-c.sh
# descpt: remove ALL commented lines from c-file
# 20261021
# last: 20261021
# ---

# === MAIN ===
if [ $# -ne 1 ]; then
	printf "[e] usage: remove-all-commented-lines-c <filename.c>\n\n"
	exit 1
else
	fname_c="$1"
fi

if [ ! -f "${fname_c}" ]; then
	printf "[e] no such filename: '%s' \n\n" "${fname_c}"
	exit 1
fi

sed -e '/^\s*\/\/ /d' -e '/^\s*\//d' -e '/^\s*\*\//d' -e '/^\s*\* /d' "${fname_c}"
printf "[i] done\n\n"

