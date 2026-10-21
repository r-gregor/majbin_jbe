#! /usr/bin/env bash
# fname: fm.sh
# descpt: launch MS Win file explorer
# 20260929 v1
# last: 
# ---


if [ $# -eq 1 ]; then
	CURDIR="$1"
else
	CURDIR="."
fi

	cygstart explorer /E,"$(cygpath -w ${CURDIR})"

