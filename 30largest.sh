#! /usr/bin/env bash
# fname: 30largest.sh
# descpt: displays top 30 (6-times 5 elements)  largest files and directories
# 20261002 v1
# last: 20261002
# ---

unset files_and_dirs_list
declare -a files_and_dirs_list

printf "[i] top 30 largest files and dirs\n"
printf -- "---\n"

readarray -t files_and_dirs_list < <(sudo du -h --max-depth=1 / 2>/dev/null | sort -hr | head -n 6 | cut -d'/' -f2)

for filedir2 in "${files_and_dirs_list[@]}"; do
	sudo du -ah --max-depth=2 "/${filedir2}" 2>/dev/null | sort -hr | column -t | head -n5
	printf -- "---\n"
done

printf "[i] done\n\n"

