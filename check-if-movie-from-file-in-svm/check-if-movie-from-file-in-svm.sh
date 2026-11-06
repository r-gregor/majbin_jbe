#! /usr/bin/env bash
# fname: check-if-movie-from-file-in-svm.sh
# descpt: check if movie from 'MOVIES_CHECKOUT.txt' in 'Seivom' (_DSVM.txt)
# 20261105 v1
# 20261106 v2: remove cpaitalize function calls and compare lowercase ${VARNAME,,} varnames
#               HUGE speedup!
# last: 20261106
# ---

# === GLOBALS ===
dsvm_mvs_pth="${HOME}/majstaf/${HST}git/prenos/seivom/_DSVM.txt"
chk_mvs_pth="${HOME}/majstaf/majmedia/MOVIES_CHECKOUT.txt"

if [[ ! -f "${dsvm_mvs_pth}" || ! -f "${chk_mvs_pth}" ]]; then
	printf "[e] either '%s' or '%s' missing\n\n" "${dsvm_mvs_pth##*/}" "${chk_mvs_pth##*/}"
	exit 1
fi

unset found_movies
unset dsvm_movies_list
unset chk_movies_list
declare -a found_movies
declare -a dsvm_movies_list
declare -a chk_movies_list

# === FUNCTIONS ===
printout_dsvm_movies_list() {
	for DSVMEL in "${dsvm_movies_list[@]}"; do
		printf "'%s'\n" "${DSVMEL,,}"
	done
	printf "\n"
}

printout_chk_movies_list() {
	for CHKEL in "${chk_movies_list[@]}"; do
		printf "'%s'\n" "${CHKEL,,}*"
	done
	printf "\n"
}

# === MAIN ===
printf "[i] checking which movies from '%s' are already in 'Seivom':\n" "${chk_mvs_pth##*/}"

readarray -t dsvm_movies_list < <(cat "${dsvm_mvs_pth}" | grep -v -- "---\|===" | sort | uniq)
readarray -t chk_movies_list < <(cat "${chk_mvs_pth}" | tr "[:upper:]" "[:lower:]" | sed 's/ ([0-9]\{4\})//' | sort | uniq)

# === TESTS ===
# printout_dsvm_movies_list
# read -r -p "OK?"
# 
# printout_chk_movies_list
# read -r -p "OK?"
# ===

for CHKMV in "${chk_movies_list[@]}"; do
	for DSVMV in "${dsvm_movies_list[@]}"; do
		if [[ "${DSVMV,,}" =~ "${CHKMV,,}" ]]; then
			# printf "'%s' and '%s' match\n" "${DSVMV,,}" "${CHKMV,,}"
			found_movies+=( "${DSVMV}" )
		fi
	done
done

for MV in "${found_movies[@]}"; do
	printf "\t${MV}\n"
done

printf "\n"

