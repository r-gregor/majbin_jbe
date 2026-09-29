#! /usr/bin/env bash
# fname: no-descpt-commands-list.sh
# descpt: display list of majbin/*.sh commands  WITHOUT description
# 202609228
# last: 20260928
# ---

# === GLOBALS ===
unset found_bash_commands_without_descpt
declare -a found_bash_commands_without_descpt
PTH="${HOME}/majstaf/majbin/"

# === MAIN ===

# check for 'descpt: ' in top 5 lines of basj script
for FFF in $(find "${PTH}"/* -maxdepth 1 -type f -name "*\.sh"); do
	count=5
	while read -r LINE; do
		if [ $count -lt 1 ]; then
			INSERT="${FFF//${PTH}/}"
			found_bash_commands_without_descpt+=( "${INSERT/\//}" )
			break
		fi

		if [[ "${LINE}" =~ 'descpt: ' ]]; then
			break
		else
			((count--))
		fi
	done < "${FFF}"
done

if [ "${#found_bash_commands_without_descpt[@]}" -lt 1 ]; then
	printf "[E] no *.sh file WITHOUT 'descpt: ' line found\n\n"
	exit 1
fi


for CMD in "${found_bash_commands_without_descpt[@]}"; do
	printf "%s %s\n" "${CMD}"
done

printf "\n"

