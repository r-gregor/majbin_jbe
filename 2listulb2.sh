#! /usr/bin/env bash
# fname: 2listulb2.sh
# descpt: list all soft-linked scripts in ~/.local/bin/
# 20260929 v1
# last: 20260929
# ---

clear
echo "List of \"soft-linked\" scripts on ~/.local/bin:"
echo

for aaa in $(find ~/.local/bin -type l)
	#do basename "${aaa}"
	do ls -lgG "${aaa}" | awk '{printf "%s;%s\n", $7, $9}'
done
echo

