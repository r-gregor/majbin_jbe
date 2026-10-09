#! /usr/bin/env bash
# fname: vedit-mfjl-efzf.sh
# descpt: vim-edit multiple files single file from fzf-sellection -- exact match
# 20261006 v1
# last: 20261006
# ---

# === FUNCTIONS ===
FZFCMD() {
	fzf -e -m --reverse
}

vcmd() {
	vim -p
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
