#! /usr/bin/env bash
# fname: nlst.sh
# descpt: (new ls) list files 'YYYY-mm-dd fname' sorted by timestamp
# 20261001 v1
# last: 20261001
# ---

# CMMND='stat --printf="%y %n\n" * | cut -b 1-11,36- | sort -r -k1 -k2'

if [ $# -eq 1 ]; then
	LSDIR="$1"
	cd "${LSDIR}" && stat --printf="%y %n\n" * | sort -r -k1 -k2 | cut -b 1-11,36-
else
	stat --printf="%y %n\n" * | sort -r -k1 -k2 | cut -b 1-11,36-
fi

