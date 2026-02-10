#! /usr/bin/env bash
# filename: add-file-to-prenos-jbe
# 20260210 jbe v1
# last: 20260210
# ---

set -e

DEST="${JGPRNS}"

earg=false
jarg=false
marg=false
aarg=false
farg=false


usage() {
cat <<USAGE

usage: add-file-to-prenos -[e,j,m,a,h] -f <file name>
		-e	add file to update_en  and/or
		-j	add file to update_jbe and/or
		-m	add file to update_mdb or
		-a	add file to update_jbe and update_mdb and update_en

		-f <file name> is mandatory!

		-h	print this message
USAGE
}

NM=""

while getopts "ejmahf:" arg; do
	case $arg in
		e)
			earg=true
			NM+=" en "
			;;
		j)
			jarg=true
			NM+=" jbe "
			;;
		m)
			marg=true
			NM+=" mdb "
			;;
		a)
			aarg=true
			NM="en jbe mdb"
			;;
		f)
			farg=true
			fname=$OPTARG
			;;
		h)
			usage
			exit
			;;
		*)
			usage
			exit
			;;
	esac
done

if [ "${farg}" != "true" ]; then
	echo "[ERROR] no file selected"
	usage
	exit
fi

if [ ! -f ${fname} ]; then
	echo "[ERROR] no such file"
	exit
fi

if [ "${NM}" == "" ]; then
	echo "[ERROR] no destination"
	exit
fi

for dest in ${NM}; do
	PATH="${DEST}/update_${dest}"
	if [ ! -d "${PATH}" ]; then
		echo "[ERROR] no such directory: ${PATH}"
		exit
	fi

	/usr/bin/cp -iv ${fname} ${PATH}/
done

