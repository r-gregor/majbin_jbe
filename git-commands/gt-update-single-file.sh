#! /usr/bin/env bash
# fname: gt-update-single-file.sh
# descpt: Update file from src-dir to git-repository
# 20260301 v1
# 20260401 v2: added 'OK?' check into update_file_to_git() function
# 20260924 v3: can be run from anywhere for any file
#              checks for SRC and DEST directories/files
# 20260924 v4: unified scripts for linux
#              HST and system info from exported global variable
# 20261005:    renamed to -single-
# last: 20261005
# ---

if [ $# -ne 1 ]; then
	printf "\tUsage: gupdate-single-file <src_fname>\n\n"
	exit 1
else
	src_fname=$(realpath "$1")
fi

if [ ! -f ${src_fname} ]; then
	printf "[E] no such source file: %s\n\n" "${src_fname}"
	exit 1
fi

SRCF="${src_fname}"
SRCD="${SRCF%/*}"

dest_fname=$(echo ${src_fname} | sed "s/\(.*majstaf\)\/\([[:alpha:]]\+\)\/\(.*\)/\1\/${HST}git\/\2_${HST}\/\3/")

DSTF="$(realpath "${dest_fname}")"
DSTD="${DSTF%/*}"

if [ ! -d "${DSTD}" ]; then
	printf "[E] no such destination: %s\n\n" "${DSTD}"
	exit 1
fi

ptrn="majstaf/${HST}git"

if [[ ! "${DSTD}" =~ ${ptrn} ]]; then
	printf "[E] file '%s' must be copied over directly\n\n" "${SRCF}"
	exit 1
fi

if [ ! -f "${DSTF}" ]; then
	printf "[W] no such file on destination: %s\n" "${DSTF##*/}"
	read -r -p "[?] Continue?"
fi

# === MAIN ===
printf -- "%s\n%s\n%s\n" \
	"---" \
	"[i] from: ${SRCF}" \
	"[i] to:   ${DSTF}"
read -r -p "[?] Continue? (y/n) " ans1

if [[ "${ans1}"  == "y" || "${ans1}"  == "Y" ]]; then
	printf "[+] "
	cp -iv "${SRCF}" "${DSTF}"
else
		printf "file '%s' NOT updated\n\n" "${SRCF}"
fi

printf "\n"

