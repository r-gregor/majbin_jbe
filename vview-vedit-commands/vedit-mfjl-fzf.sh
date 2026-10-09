#! /usr/bin/env bash
# fname: vedit-mfjl-fzf.sh
# descpt: vim-edit multiple files from fzf-sellection
# 20261002
# last: 20261002
# ---

# === FUNCTIONS ===
vcmd() {
	vim -p
}

FZFCMD() {
	fzf -m --reverse
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
done | xargs -ro vcmd

printf "\n"
