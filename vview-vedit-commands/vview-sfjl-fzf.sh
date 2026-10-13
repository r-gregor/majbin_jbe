#! /usr/bin/env bash
# fname: vview-sfjl-fzf.sh
# descpt: vim-viev single file from fzf-sellection
# 20261006 v1
# last: 20261006
# ---

# === GLOBALS ===
vcmd='vim -M'

# === FUNCTIONS ===
FZFCMD() {
	fzf --reverse
}

# === MAIN ===
readarray -t selections < <(cd "${HOME}" && FZFCMD)

if [ "${#selections[@]}" -eq 0 ]; then
	printf "[i] nothing selected\n\n"
	exit 0
fi

printf "[i] selected:\n"
for selection in "${selections[@]}"; do
	printf "%s\n" "${HOME}/${selection}"
done

for selection in "${selections[@]}"; do
	printf "${HOME}/${selection} "
done | xargs -ro ${vcmd}

printf "\n"

