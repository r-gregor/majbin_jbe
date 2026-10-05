#! /usr/bin/env bash
# fname: update-10-commands-without-descpt.sh
# descpt: update 10 (head -n10) commands from list created by no-descpt-commands-list
# 20260929 v1
# last: 20260927
# ---

# === GLOBALS ===
unset ten_bash_scripts_without_descpt
unset ten_bash_scripts_to_git_update
declare -a ten_bash_scripts_without_descpt

if [ $# -eq 1 ]; then
	SRCDIR="$(realpath "$1")"
	printf "[i] srcdir: '%s'\n" "${SRCDIR}"
	printf -- "---\n"
	if [ ! -d "${SRCDIR}" ]; then
		printf "[E] no such directory: '%s'\n" "${SRCDIR}"
		exit 1
	fi
else
	SRCDIR="${HOME}/majstaf/majbin"
fi

ten_bash_scripts_to_git_update="${SRCDIR}/ten_bash_scripts_to_git_update_$(date +"%Y%m%d_%H%M%S").txt"

# === MAIN ===
> "${ten_bash_scripts_to_git_update}"

readarray -t ten_bash_scripts_without_descpt < <(no-descpt-commands-list | head -n 10)

if [ "${#ten_bash_scripts_without_descpt[@]}" -lt 1 ]; then
	printf "[ERROR] no *.sh file WITHOUT 'descpt: ' line found\n\n"
	exit 1
fi

for CMD in "${ten_bash_scripts_without_descpt[@]}"; do
	printf "%s\n" "${SRCDIR}/${CMD}" | tee -a "${ten_bash_scripts_to_git_update}"
done

for CMD in "${ten_bash_scripts_without_descpt[@]}"; do
	printf "%s\n" "${SRCDIR}/${CMD}"
done | xargs -ro vim

printf "\n"

