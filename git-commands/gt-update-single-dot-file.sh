#! /usr/bin/env bash
# fname: gt-update-single-dot-file.sh
# descpt: Update single dot-file from src-dir to git-repository
# 20261007
# last: 20261007
# ---

# === GLOBALS ===
GDTDST="${HOME}/majstaf/${HST}git/dotfiles_${HST}"


# === MAIN ===
if [ $# -ne 1 ]; then
	printf "[u] usage: gupdate-single-dot-file <src_fname>\n\n"
	exit 1
else
	src_fname=$(realpath "$1")
fi

if [ ! -f ${src_fname} ]; then
	printf "[e] no such source file: '%s'\n\n" "${src_fname}"
	exit 1
fi

SRCF="${src_fname}"
SRCD="${SRCF%/*}"

dest_fname="${src_fname/${HOME}/${GDTDST}}"
DSTF="$(realpath "${dest_fname}")"
DSTD="${DSTF%/*}"

if [ ! -d "${DSTD}" ]; then
	printf "[e] no such destination: '%s'\n" "${DSTD}"
	printf "[!] file '%s' must be copied over directly\n\n" "${SRCF}"
	exit 1
fi

ptrn="majstaf/${HST}git"

if [[ ! "${DSTD}" =~ ${ptrn} ]]; then
	printf "[e] file '%s' must be copied over directly\n\n" "${SRCF}"
	exit 1
fi

if [ ! -f "${DSTF}" ]; then
	printf "[!] no such file on destination: %s\n" "${DSTF##*/}"
	read -r -p "[?] continue?"
fi

# === MAIN ===
printf -- "%s\n%s\n%s\n" \
	"---" \
	"[i] from: ${SRCF}" \
	"[i] to:   ${DSTF}"
read -r -p "[?] continue? (y/n) " ans1

if [[ "${ans1}"  == "y" || "${ans1}"  == "Y" ]]; then
	printf "[+] "
	cp -iv "${SRCF}" "${DSTF}"
else
		printf "[!] file '%s' not updated\n\n" "${SRCF}"
fi

printf "\n"

