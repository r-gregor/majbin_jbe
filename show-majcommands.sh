#! /usr/bin/env bash
# fname: show-majcommands.sh
# descpt: make list of majcommands with decription
# 20261112: same as majcommands-list/majcommands-list.sh
# last: 20261112

# === GLOBALS ===
unset found_bash_commands
declare -a found_bash_commands
PTH="${HOME}/majstaf/majbin/"

# === MAIN ===
for FFF in $(find "${PTH}"/* -maxdepth 1 -type f -name "*\.sh"); do
	while read -r LINE; do
		if [[ "${LINE}" =~ 'descpt: ' ]]; then
			INSERT="${FFF//${PTH}/}"
			found_bash_commands+=( "${INSERT/\//}" )
			break
		else
			continue
		fi
	done < "${FFF}"
done

if [ "${#found_bash_commands[@]}" -lt 1 ]; then
	printf "[e] no *.sh file with 'descpt: ' line found\n\n"
	exit 1
fi


for CMD in "${found_bash_commands[@]}"; do
	printf "%-60s %s\n" "${CMD##*/}" "$(grep '^# descpt: ' "${PTH}/${CMD}" | sed 's/# descpt: //')"
done

printf "\n"

