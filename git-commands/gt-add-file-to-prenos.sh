#! /usr/bin/env bash
# filename: add-file-to-prenos-mdb
# descpt: add file to prenos git-repo
# 20260210 mdb v1
# last: 20260210
# ---

set -e

PRNS_DEST="${HOME}/majstaf/${HST}git/prenos"

earg=false
jarg=false
marg=false
aarg=false
farg=false


usage() {
cat <<USAGE

usage: add-file-to-prenos -[e,j,m,a,h] -f <file name>
        -e    add file to update_en  and/or
        -j    add file to update_jbe and/or
        -m    add file to update_mdb or
        -a    add file to update_jbe and update_mdb and update_en

        -f    <file name> is mandatory!

        -h    print this message
USAGE
}

unset NM
declare -a NM

while getopts "ejmahf:" arg; do
	case $arg in
		e)
			earg=true
			NM+=("en")
			;;
		j)
			jarg=true
			NM+=("jbe")
			;;
		m)
			marg=true
			NM+=("mdb")
			;;
		a)
			aarg=true
			NM=()
			NM=("en jbe mdb")
			;;
		f)
			farg=true
			fname="${OPTARG}"
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
	printf "[E] no file selected\n\n"
	usage
	exit 1
fi

if [ ! -f "${fname}" ]; then
	printf "[E] no such file\n\n"
	exit 1
fi

if [ "${NM}" == "" ]; then
	printf "[E] no destination\n\n"
	exit 1
fi

for dest in "${NM[@]}"; do
	UPDTDIR="${PRNS_DEST}/update_${dest// /}"
	if [ ! -d "${UPDTDIR}" ]; then
		printf "[E] no such directory: ${UPDTDIR}\n\n"
		exit 1
	fi

	/usr/bin/cp -iv "${fname}" "${UPDTDIR}"/
done

printf "\n"

