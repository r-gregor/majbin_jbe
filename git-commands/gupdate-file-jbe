#! /usr/bin/env bash
# fname: gupdate-file-jbe
# 20260313 v1 jbe
# 20260408 v2 jbe: added 'OK?' check into update_file_to_git() function
# last: 20260408
# ---

HST="jbe"
SRCDIR=$PWD

if [[ ! "${SRCDIR}" =~ "majstaf" ]]; then
	printf "[ERROR] not working outside ~/majstaf/\n"
	printf "\n"
	exit
fi

if [[ $# -ne 1 ]]; then
	cat <<EOF
	Usage: gupdate-file ./<fname>

EOF
	exit
else
	fname="$1"
fi

if [[ ! -f ./"${fname}" ]]; then
	echo "[ERROR] no such file"
	exit
fi

SRCF="${SRCDIR}/${fname}"
DSTF=$(echo $SRCDIR/${fname} | sed "s/\(.*majstaf\)\/\([[:alpha:]]\+\)\/\(.*\)/\1\/${HST}git\/\2_${HST}\/\3/")

update_file_to_git() {
	printf "%s\n%s\n%s\n" \
		"from: ${SRCF}" \
		"to:   ${DSTF}" \
		"---"
	read -p "OK?"
	cp -iv "${SRCF}" "${DSTF}"
}

# MAIN
update_file_to_git

printf "\n"

