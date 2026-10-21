#! /usr/bin/env bash
# fname: nlc.sh
# descpt: (new ls) list files 'YYYY-mm-dd fname' sorted by name in columns
# 20261001 v1
# last: 20261001
# ---

CMMND='stat --printf="%y %n\n" * | cut -b 1-11,12-19,36-'

if [ $# -eq 1 ]; then
	LSDIR="$1"
	cd "${LSDIR}" && stat --printf="%y %n\n" * | cut -b 1-11,36- | column -c $(tput cols)
else
	stat --printf="%y %n\n" * | cut -b 1-11,36- | column -c $(tput cols)
fi

