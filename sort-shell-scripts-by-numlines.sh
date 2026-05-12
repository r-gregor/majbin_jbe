#! /usr/bin/env bash
# filename: sort-shell-scripts-by-numlines
# 20260210 jbe v1
# 20260224 en  v2: updated find command to not search files with 3-letters extension (*.png, *.txt, ...)
# last change: 20260224
# ---

# for FFF in $(find * -type f); do echo "$(wc -l $FFF)"; done |sort -nr | column -t | less
# for FFF in $(find * -type f);do (echo $(file -ib $FFF) | grep 'shellscript') > /dev/null; if [ $? == 0 ]; then echo "shellscript: $FFF"; fi; done

# for FFF in $(find * -type f); do
for FFF in $(find * -type f ! -name "*.???"); do
	(echo $(file -ib $FFF) | grep 'shellscript') > /dev/null
	if [ $? -eq 0 ]; then
		echo "$(wc -l $FFF)"
	fi
done | sort -nr | column -t | head -n 15

