#! /usr/bin/env bash
# fname: check-if-movie-from-file-in-svm.sh
# descpt: check if movie from 'MOVIES_CHECKOUT.txt' in 'Seivom' (_DSVM.txt)
# 20261105 v1
# last: 20261105
# ---

# === GLOBALS ===
seivom_pth="${HOME}/majstaf/${HST}git/prenos/seivom"
mvs_pth="${HOME}/majstaf/majmedia/MOVIES_CHECKOUT.txt"

unset found_movies
declare -a found_movies

# === MAIN ===
printf "[i] checking which movies from '%s' are already in 'Seivom':\n" "${mvs_pth##*/}"
while read -r MVNM; do
	MV="$(grep -irh -- "${MVNM}" "${seivom_pth}/_DSVM.txt")"
	if [[ "${MV}" != "" ]]; then
		found_movies+=( "${MV}" )
	fi
done < <( capitalize-and-sort-movie-names "${mvs_pth}" )

for MV in "${found_movies[@]}"; do
	printf "\t${MV}\n"
done

printf "\n"

