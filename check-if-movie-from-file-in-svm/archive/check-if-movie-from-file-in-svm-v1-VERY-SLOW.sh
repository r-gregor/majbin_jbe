#! /usr/bin/env bash
# fname: check-if-movie-from-file-in-svm.sh
# descpt: check if movie from 'MOVIES_CHECKOUT.txt' in 'Seivom' (_DSVM.txt)
# 20261105 v1
# last: 20261105
# ---

# === GLOBALS ===
dsvm_pth="${HOME}/majstaf/${HST}git/prenos/seivom/_DSVM.txt"
mvs_pth="${HOME}/majstaf/majmedia/MOVIES_CHECKOUT.txt"

if [[ ! -f "${dsvm_pth}" || ! -f "${mvs_pth}" ]]; then
	printf "[e] either '%s' or '%s' missing\n\n" "${dsvm_pth##*/}" "${mvs_pth##*/}"
	exit 1
fi

unset found_movies
declare -a found_movies

# === MAIN ===
printf "[i] checking which movies from '%s' are already in 'Seivom':\n" "${mvs_pth##*/}"
while read -r MVNM; do
	MV="$(LC_ALL=C grep -irh -- "${MVNM}" "${dsvm_pth}")"
	if [[ "${MV}" != "" ]]; then
		found_movies+=( "${MV}" )
	fi
done < <( capitalize-and-sort-movie-names "${mvs_pth}" )

for MV in "${found_movies[@]}"; do
	printf "\t${MV}\n"
done

printf "\n"

