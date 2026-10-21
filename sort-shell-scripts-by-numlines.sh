#! /usr/bin/env bash
# fname: sort-shell-scripts-by-numlines.sh
# descpt: Sort bash scripts by number of lines -- descending
# 20261006 v1
# last: 20261006
# ---

# === MAIN ===
for FFF in $(find * -type f ! -name "*.???"); do
	(echo "$(file -ib "${FFF}")" | grep 'shellscript') > /dev/null
	if [ $? -eq 0 ]; then
		echo "$(wc -l "${FFF}")"
	fi
done | sort -nr | column -t | head -n 15


