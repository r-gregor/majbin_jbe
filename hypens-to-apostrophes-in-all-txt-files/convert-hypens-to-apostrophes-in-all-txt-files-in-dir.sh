#! /usr/bin/env bash
# fname: convert-hypens-to-apostrophes-in-all-txt-files-in-dir.sh
# 2060312 en
# last: 20260312
# ---

for FFF in *.txt; do
	sed -i "s/\([[:alpha:]]\)'\([[:alpha:]]\{1,2\} \)/\1´\2/g" $FFF
	sed -i "s/\([[:alpha:]]\)'\([[:alpha:]]\{1,2\}$\)/\1´\2/g" $FFF
	sed -i "s/\([[:alpha:]]\)'\([[:alpha:]]\{1,2\}[,.:]$\)/\1´\2/g" $FFF
done

