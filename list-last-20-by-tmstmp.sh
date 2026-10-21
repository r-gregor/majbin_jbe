#! /usr/bin/env bash
# fname: list-last-20-by-tmstmp.sh
# descpt:  list last filenames by trailing timestamp *-yyyymmdd*
# 20261001 v1
# last: 20261001
# ---

unset curryr

if [ "${CURRENT}_YEAR_ENV" -ne $(date +%Y) ]; then
		curryr="${CURRENT}_YEAR_ENV"
	else
		curryr=$(date +%Y)
fi

if [ $# -ne 1 ]; then
    myyr="${curryr}"
else
    myyr="$1"
fi

find * -maxdepth 1 -type f -regex ".*${myyr}[0-9][0-9][0-9][0-9]\..*" | sort -n | head -n20

