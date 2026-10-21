#! /usr/bin/env bash
# fname: relink-shell-link-names-to-names-with-sh.sh
# descpt: relink scrips from external files-list to existing link in ~/.local/bin
# 20261001 v1
# last: 20261001
# ---

# oneliner:
# while IFS=';' read link spath; do printf "%-30s --> %s\n" "${link}" "${spath}"; done < sflinks.txt

ULB="${HOME}/.local/bin"

while IFS=';' read slink spath; do
	if [ -f "${spath}.sh" ]; then
		ln -snf "${spath}.sh" "${ULB}/${slink}"
	fi
done < sflinks.txt

