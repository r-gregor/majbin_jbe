#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	LSDIR="$1"
	cd ${LSDIR} && stat --printf="%y %n\n" * | sort -r -k1 -k2 | cut -b 1-11,36- | column -c $(tput cols)
else
	stat --printf="%y %n\n" * | sort -r -k1 -k2 | cut -b 1-11,36- | column -c $(tput cols)
	
fi

