#! /usr/bin/env bash
# fname: softlink1-fname-to-ulb.sh
# descpt: soft-link bash script to '~/.local/bin/'
# 20261021
# last: 20261021
# ---

# === GLOBALS ===
source_path="$(dirname "$1")"
dest_path="${HOME}/.local/bin"

fname_full="$(basename "$1")"
fname="${fname_full%%.*}"
ext="${fname_full##*.}"

# === MAIN ===
if [ ! $# -eq 1 ]; then
	printf "[e] usage: softlink1-fname-to-ulb <scriptname>\n\n"
	exit 1
fi

if [ ! -e "${source_path}/${fname_full}" ]; then
	printf "[e] no such file: '%s'\n\n" "${fname_full}"
	exit 1
fi

# execute
printf "[i] soft-linking '%s' to '%s' ...\n" "${fname_full}" "${HOME}/.local/bin/"
ln -sv "$(realpath "${source_path}/${fname_full}")" "${dest_path}/${fname}"

printf "\n"

