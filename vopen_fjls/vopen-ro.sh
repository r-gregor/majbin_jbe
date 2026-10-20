#! /usr/bin/env bash
# fname: vopen-ro.sh
# descpt: opens files list from stdin in 'read-only' mode with vim
# 20261008 v1
# 20261019 v2 test if stdin line is not a file
# last: 20261019
# ---

# === MAIN ===
if [ ! -p /dev/stdin ] || [ $# -ne 1 ]; then
	printf "[E] must receive output from stdin\n"
	printf "[!] usage: command_with_output_to_stdout | vopen-ro -\n\n"
	exit 1
fi

while read LINE; do
	if [ ! -f "${LINE}" ]; then
		continue
	else
		printf "${LINE}\n"
	fi
done | /usr/bin/xargs -ro /usr/bin/vim -M

