#! /usr/bin/env bash
# fname: vview-files-from-vim-history.sh
# descpt: vim-viev files from vim-history
# 20261006 v1
# last: 20261006
# ---

# === GLOBALS ===
unset fljs
unset selection
unset finallist
fljs=()


# === FUNCTIONS ===
FZFCMD() {
	fzf -e -m --reverse
}

# === MAIN ===
for LINE in $(grep -E "^> .*[0-9]{8}\.txt" ~/.viminfo | cut -d' ' -f2-); do
	fljs+=("${LINE//\~/${HOME}}")
done

selection=$(for fjl in "${fljs[@]}"; do echo "${fjl}"; done 2>/dev/null | FZFCMD)

if [ "${selection}" == "" ]; then
	printf "[i] nothing selected\n\n"
	exit 0
fi

for vfjl in "${selection[@]}"; do
	if [ ! -f "${vfjl}" ]; then
		printf "[i] file: '%s' no longer exists: skipping ...\n" "$(basename "${vfjl}")"
	else
		finallist+=("${vfjl}")
	fi
done

if [ "${finallist}" == "" ]; then
	printf "[i] nothing selected\n\n"
	exit 0
fi

for fjl in "${finallist[@]}"; do
	echo -n "${fjl} "
done | xargs -ro vim -pM

printf "\n"

