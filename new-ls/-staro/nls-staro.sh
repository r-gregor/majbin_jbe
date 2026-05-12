#! /usr/bin/env bash

CURDIR=$PWD
# CMMND="stat --printf="%y %n\n" | cut -b 1-11,12-19,36- | sort -r -k1 -k2"
CMMND='stat --printf="%y %n\n" * | cut -b 1-11,12-19,36-'

if [ $# -eq 1 ]; then
	LSDIR="$1"
	# cd ${LSDIR} && stat --printf="%y %n\n" * | cut -b 1-11,36-
	cd ${LSDIR} && eval ${CMMND}
else
	# stat --printf="%y %n\n" * | cut -b 1-11,36-
	eval ${CMMND}
	
fi

#CURDIR=$PWD

