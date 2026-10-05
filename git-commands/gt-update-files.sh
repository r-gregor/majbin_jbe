#! /usr/bin/env bash
# fname: gt-update-files.sh
# descpt: Update single file from src-dir to git-repository
# 20260301 v1
# 20260401 v2: added 'OK?' check into update_file_to_git() function
# 20260924 v3: can be run from anywhere for any file
#              checks for SRC and DEST directories/files
 #20260924 v4: unified scripts for linux
#              HST and system info from exported global variable
# 20261005 v5: multiple files (works for single files too)
# last: 20261005
# ---

if [ $# -lt 1 ]; then
	printf "\tUsage: gt-update-files <src_fname/s>>\n\n"
	exit 1
fi

run_update_file() {
	local src_f
	local dst_f

	src_f="${1}"
	dst_f="${2}"

	if [ ! -f "${dst_f}" ]; then
		printf "[W] no such file on destination: %s" "${dst_f##*/}"
		read -r -p "[?] continue (y/n)?" ans

		if [[ "${ans}"  != "y" && "${ans}"  != "Y" ]]; then
			return
		fi
	fi

	printf -- "%s\n%s\n%s\n" \
		"---" \
		"[i] from: ${src_f}" \
		"[i] to:   ${dst_f}"
	read -r -p "[?] Continue? (y/n) " ans1

	if [[ "${ans1}"  == "y" || "${ans1}"  == "Y" ]]; then
		printf "[+] "
		cp -iv "${src_f}" "${dst_f}"
	else
		printf "file '%s' NOT updated\n\n" "${src_f}"
	fi
}

# === MAIN ===
unset files_to_update
declare -a files_to_update

while [ "$1" ]; do
	files_to_update+=("$1")
	shift
done

if [ "${#files_to_update[@]}" -lt 1 ]; then
	printf "[E] no files selected\n\n"
	exit 1
fi

ptrn="majstaf"
for FFF in "${files_to_update[@]}"; do
	if [ ! -f "${FFF}" ]; then
		printf "[E] no such file: '%s'\n\n" "${FFF}"
		exit 1
	elif [[ ! "$(realpath "${FFF}")" =~ ${ptrn} ]]; then
		printf "[E] file '%s' must be copied over directly\n\n" "${FFF}"
		exit 1
	fi
done

printf "[i] files to be updated:\n"
for fjl1 in "${files_to_update[@]}"; do
	printf "\t%s\n" "${fjl1}"
done
read -r -p "[?] continue (y/n)? " ans0

if [[ "${ans0}"  != "y" && "${ans0}"  != "Y" ]]; then
	printf "\n"
	exit 1
fi

for FFF in "${files_to_update[@]}"; do
	src_fname=$(realpath "${FFF}")

	SRCF="${src_fname}"
	SRCD="${SRCF%/*}"

	dest_fname=$(echo "${src_fname}" | sed "s/\(.*majstaf\)\/\([[:alpha:]]\+\)\/\(.*\)/\1\/${HST}git\/\2_${HST}\/\3/")

	DSTF="$(realpath "${dest_fname}")"
	DSTD="${DSTF%/*}"

	if [ ! -d "${DSTD}" ]; then
		printf "[E] no such destination: %s\n\n" "${DSTD}"
		exit 1
	fi

	run_update_file "${SRCF}" "${DSTF}"
done

printf "\n"
