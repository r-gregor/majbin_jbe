#! /usr/bin/env bash
# fname: vview-mfjl-fzf.sh
# descpt: vim-viev multiple files from fzf-sellection
# 20261006 v1
# last: 20261006
# ---

# === GLOBALS ===
vcmd='vim -Mp'


# === FUNCTIONS ===
FZFCMD() {
	fzf -m --reverse
}

# === MAIN ===
printf "\n"
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

