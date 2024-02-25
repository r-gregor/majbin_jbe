#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	LSDIR="$1"
	cd ${LSDIR} && stat --printf="%y %n\n" * | cut -b 1-11,36-
else
	stat --printf="%y %n\n" * | cut -b 1-11,36-
	
fi


