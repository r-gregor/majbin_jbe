#! /usr/bin/env bash
# fname: compare-funclists.sh
# descpt: compare two functions list
# 20261016 v1
# last: 20261016
# ---

# === GLOBALS ===
unset f1_func_list
unset f2_func_list

unset fname1
unset fname2

declare -a  f1_func_list
declare -a  f2_func_list

# === MAIN ===
if [ $# -ne 2 ]; then
	printf "[!] usage compare <filename 1> <filename 2>\n\n"
	exit 1
else
	fname1="${1}"
	fname2="${2}"

	if [ ! -f "${fname1}" ]; then
		printf "[E] no such file: '%s'\n\n" "${fname1}"
		exit 2
	fi

	if [ ! -f "${fname2}" ]; then
		printf "[E] no such file: '%s'\n\n" "${fname2}"
		exit 2
	fi

	bn_fname1="$(basename "${fname1}")"
	bn_fname2="$(basename "${fname2}")"
fi

while read -r f1fn; do
	f1_input="${f1fn%%(*}"
	f1_func_list+=( "${f1_input}" )
done < <(grep -E '[[:alpha:]]\(\) {' "${fname1}" 2>/dev/null | sort |uniq)

if [ "${#f1_func_list[@]}" -eq 0 ]; then
	printf "[E] file '%s' is not funclist file\n\n" "${bn_fname1}"
	exit 1
fi

while read -r f2fn; do
	f2_input="${f2fn%%(*}"
	f2_func_list+=( "${f2_input}" )
done < <(grep -E '[[:alpha:]]\(\) {' "${fname2}" 2>/dev/null | sort |uniq)

if [ "${#f2_func_list[@]}" -eq 0 ]; then
	printf "[E] file '%s' is not funclist file\n\n" "${bn_fname2}"
	exit 1
fi

for f1_fn in "${f1_func_list[@]}"; do
	found=0
	for f2_fn in ${f2_func_list[@]}; do
		if [ "$f1_fn" == "${f2_fn}" ]; then
			found=1
			break
		fi
	done
	if [ "${found}" -eq 0 ]; then
		printf "%-20s from '%s' NOT in '%s'\n" "${f1_fn}()" "${bn_fname1}" "${bn_fname2}"
	fi
done

printf "\n"

