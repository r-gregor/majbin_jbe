#! /usr/bin/env bash
# filename: gt-dest-src-diffs.sh
# descpt: check for diff-s of all files in git-repository with original files
# 20260924
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# 20261005: no tmp file --> array ...
# last: 20261005
# ---

CURRDIR="${PWD}"
MAJSTAF="${HOME}/majstaf"
MAJSTAF_G="${MAJSTAF}/${HST}git"

cd "${MAJSTAF_G}/dotfiles_${HST}"
printf "[i] diffs: dotfiles_en ...\n"

unset DTFOUNDDIFFS
declare -a DTFOUNDDIFFS

readarray -t DTFOUNDDIFFS < <(for FFF in $(ls -1A); do diff -qr "${FFF}" "${HOME}/${FFF}" 2>&1 | grep -iv 'only\|\.local/bin' | grep -v '.git'; done)
dtfound_num="${#DTFOUNDDIFFS[@]}"

if [ "${dtfound_num}" -ne 0 ]; then
	for DTFDIFF in "${DTFOUNDDIFFS[@]}"; do
		printf "\t${DTFDIFF}\n"
	done
	printf "\n"
fi

# === OTHER LOCATIONS ===
for check_dir in majbin majrcs metsys; do
	cd "${MAJSTAF_G}/${check_dir}_${HST}"
	printf "[i] diffs: ${check_dir} ...\n"

	unset FOUNDDIFFS
	declare -a FOUNDDIFFS

	readarray -t FOUNDDIFFS < <(for FFF in $(ls -1); do diff -qr "${FFF}" "${MAJSTAF}/${check_dir}/${FFF}" 2>&1 | grep -iv 'only'; done)
	found_num="${#FOUNDDIFFS[@]}"

	if [ "${found_num}" -ne 0 ]; then
		for FDIFF in "${FOUNDDIFFS[@]}"; do
			printf "\t${FDIFF}\n"
		done
		printf "\n"
	fi
	cd "${HOME}"
done

cd "${CURRDIR}"

