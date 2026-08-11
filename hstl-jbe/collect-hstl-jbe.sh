#! /usr/bin/env bash
# filename: collect-hstl-en.sh
# 20251120 v1 collect and filter out all history snapshots till today
# 20260605 v2 fname (base, temp, dest) variables
# 20260811 v3 cat command output into array, and read lines to be parsed from array
#             cleand by 'grep -v' from 'excludes-hstl-en.txt'
# 20260811 v4 external commands to process output outside of for loop --> MUTCH FASTER !!!
# last: 20260811
# ---

HNM=jbe
HNML=jbez0rg
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
SEZNAMI_DIR="$HOME/majstaf/seznami"
CURRYR=$(date +"%Y")
unset CMMNDS
declare -a CMMNDS

fname_base=COMMANDS-${HNML}-by-$(date +"%Y%m%d")
dest_fname=${fname_base}.txt

# 01-COLLECT-ALL-COMMANDS-from-history-en-dat-to-single-file.onl.txt
export LC_ALL=C
printf "[INFO] collecting hstl files into ${fname_temp} ...\n"
readarray -t CMMNDS < <(cat ${SEZNAMI_DIR}/hstl-${HNML}-${CURRYR}* | cut -b 28- | sort | uniq -c)

# 02-REMOVE-count-nums-infront-of-commands-in-single-file.onl.txt
# v4
printf "[INFO] cleaning final ${dest_fname} ...\n"
for LINE in "${CMMNDS[@]}"; do
	echo "${LINE}"
done | cut -b 9- | grep -v -f "${SRCDIR}/excludes-hstl-${HNM}.txt" > ${SEZNAMI_DIR}/${dest_fname}
# done | cut -b 9- | grep -v -f "${SRCDIR}/excludes-hstl-${HNM}.txt"

printf "[INFO] done\n"

