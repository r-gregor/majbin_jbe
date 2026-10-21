#! /usr/bin/env bash
# filename: showw.sh
# descpt: List all show-* commands and run fzf selection
# 20260209
# last: 20260209
# ---

show_cmmds=()
pth="$HOME/.local/bin"

run() {
	"${pth}/${selection}"
}

for show_cmmd in $(ls -1 "$HOME"/.local/bin/show-*); do
	show_cmmds+=( "${show_cmmd}" )
done

selection=$(for cmmd in "${show_cmmds[@]}"; do
	echo "${cmmd##*/}"
done | fzf -e --reverse)

run

