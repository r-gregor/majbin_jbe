#! /usr/bin/env bash
# filename: showw
# list all show-* commands ...
# 20260209 en
# last: 20260209

show_cmds=()
pth="$HOME/.local/bin"

for show_cmd in $(ls -1 $HOME/.local/bin/show-*); do
	show_cmds+=(${show_cmd})
done

selection=$(for cmd in "${show_cmds[@]}"; do
	echo "${cmd##*/}"
done | fzf -e --reverse)

"${pth}/${selection}"
