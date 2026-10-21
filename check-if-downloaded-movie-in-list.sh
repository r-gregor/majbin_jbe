#! /usr/bin/env bash

SVM="${HOME}/majstaf/majmedia/Seivom"
FJL="${HOME}/majstaf/majmedia/_DOWNLOADED_MOVIES.txt"

readarray -t MVS < <(ls -1d ${SVM}/* | grep -v _NOVO | cut -d'/' -f7)
readarray -t LINES < <(cat ${FJL} | grep -v '\---')

FOUND=0

for MV in "${MVS[@]}"; do
	ISIN=0
	for LINE in "${LINES[@]}"; do
		if [ "${MV}" == "${LINE}" ]; then
			ISIN=1
		fi
	done
	# test
	# echo "ISIN for $MV: ${ISIN}"
	if [ ${ISIN} == 0 ]; then
		echo "${MV} NOT in a file!"
		let FOUND=${FOUND}+1
	fi
done

if [ ${FOUND} == 0 ]; then
	echo "All movies in file"
fi

