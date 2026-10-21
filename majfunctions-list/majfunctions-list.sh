#! /usr/bin/env bash
# fname: majfunctions-list.sh
# descpt: display list of functions in "${MRCS}/funclist-${HST}" with decription
# 20261016
# last: 20261016
# ---

# === GLOBALS ===
PTH="${HOME}/majstaf/majrcs/"
fnc_lst="${PTH}/funclist-${HST}"

# === MAIN ===
while read -r LINE; do
	func_name=${LINE%%\|*}
	func_decp=${LINE##*\|}
	printf "%-20s%s\n" "${func_name}" "${func_decp}"
done < <(grep -A1 '()' "${fnc_lst}" |tr '\n' ' ' | sed 's/ -- /\n/g' |sed 's/ { # descpt: / | /g')

printf "\n"

