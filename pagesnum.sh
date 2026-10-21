#! /usr/bin/env bash
# fname: pagesnum.sh
# descpt: get number of pages in fname (approx: chars per line: 80)
# 20261001 v1
# 20261021
# last: 20261021

# === GLOBALS ===
unset FJL

# === MAIN ===
if [ $# -ne 1 ]; then
    printf "[e] usage: pagesnum + <filename>\n\n"
    exit 1
else
	FJL="$1"
fi


PGNM=$(echo "$(cat "${FJL}" | wc -l) / 80" | bc)

if [ "${PGNM}" -lt 1 ]; then
	PGNM=1
fi

printf "[i] number of pages in file '%s' is: %d\n\n" "${FJL}" "${PGNM}"

