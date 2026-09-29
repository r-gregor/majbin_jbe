#! /usr/bin/env bash
# fname: majcommands-list.sh
# descpt: make list of majcommands with decription
# 20260921 v1
# last: 20260921
# ---

unset found_bash_commands
declare -a found_bash_commands

PTH='/home/gregor.redelonghi/majstaf/majbin/'
# PTH='/home/rgregor/majstaf/majbin/'
SRC="${PTH}/git-commands"

# PTH_ESCPD='\/home\/gregor.redelonghi\/majstaf\/majbin\/'
# PTH_ESCPD="${PTH//\//\\/}"

for FFF in $(find "${PTH}"/git-commands/*  "${PTH}"/ff*/* -maxdepth 0 -type f -name "*\.sh"); do
	# INSERT="${FFF//${PTH_ESCPD}/}"
	INSERT="${FFF//${PTH}/}"
	found_bash_commands+=( "${INSERT/\//}" )
done

# echo "${found_bash_commands[@]}"
# read -r -p "[?] OK?"

for CMD in "${found_bash_commands[@]}"; do
	printf "%-60s %s\n" "${CMD}" "$(grep 'descpt' "${PTH}/${CMD}" | sed 's/# descpt: //')"
done

