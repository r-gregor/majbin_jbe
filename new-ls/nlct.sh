#! /usr/bin/env bash
# fname: nlct.sh
# descpt: (new ls) list files 'YYYY-mm-dd fname' sorted by timestamp in columns
# 20261001 v1
# last: 20261001
# ---

if [ $# -eq 1 ]; then
	LSDIR="$1"
	cd "${LSDIR}" && stat --printf="%y %n\n" * | sort -r -k1 -k2 | cut -b 1-11,36- | column -c $(tput cols)
else
	stat --printf="%y %n\n" * | sort -r -k1 -k2 | cut -b 1-11,36- | column -c $(tput cols)
fi

