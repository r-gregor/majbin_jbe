#! /usr/bin/env bash
# fname: test.sh
# 20260810 v1
# ---

unset PTH
if [ $# -eq 1 ]; then
	PTH="$1"
else
	PTH="."
fi

if [ ! -d "${PTH}" ]; then
	printf "[ERROR] no such directory: '%s'\n\n" "${PTH}"
	exit 1
fi

find "${PTH}" \( \
	-path '**/.config*' \
	-o -path '**/engit' \
	-o -path '**/.*' \
	-o -path '**/.tmp' \
	-o -path '**/snap' \
	-o -path '**/_NERAZPOREJENO' \
	-o -path '**/coding2' \
	-o -path '**/majbin' \
	-o -path '**/.vim' \) \
-prune -o -type f -print

