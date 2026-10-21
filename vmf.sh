#! /usr/bin/env bash
# fname: vmf.sh
# descpt: fzf-find any file/files and open it/them in vim
# 20261006 v1
# last: 20261006
# ---

# === MAIN ===
if [ $# -eq 1 ]; then
	PTH="$1"
	cd "${PTH}"
else
	PTH="."
fi

find "${PTH}" | fzf -m | xargs -ro vim

