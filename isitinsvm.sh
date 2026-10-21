#! /usr/bin/env bash
# fname: isitinsvm.sh
# descpt: check if part of movie name is in $SVM
# 20260929 v1
# 20261013 v2 change seivom_pth --> make it universal
# last: 20261013
# ---

# === GLOBALS ===
seivom_pth="${HOME}/majstaf/${HST}git/prenos/seivom/"

# === MAIN ===
if [ $# -ne 1 ]; then
	printf "[e] must supply a part of movie name\n\n"
	exit 1
else
	PTRN="$1"
fi

grep -i "$PTRN" "${seivom_pth}"

if [ $? -ne 0 ]; then
	echo "[i] NOT in the _DSVM.txt file: ${PTRN}"
fi

printf "\n"

