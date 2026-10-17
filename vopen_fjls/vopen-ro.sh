#! /usr/bin/env bash
# fname: vopen-ro.sh
# descpt: opens files list from stdin in 'read-only' mode with vim
# 20261008 v1
# last: 20261008
# ---

# === MAIN ===
if [ ! -p /dev/stdin ] || [ $# -ne 1 ]; then
	printf "[E] must receive output from stdin\n\n"
	exit 1
fi

/usr/bin/xargs -ro /usr/bin/vim -M

