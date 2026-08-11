#! /usr/bin/env bash
# filename: collect-hstl-en.sh
# 20251120 v1 collect and filter out all history snapshots till today
# 20260605 v2 fname (base, temp, dest) variables
# 20260811 v3 cat command output into array, and read lines to be parsed from array
#             cleand by 'grep -v' from 'excludes-hstl-en.txt'
# last: 20260811
# ---

SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
SEZNAMI_DIR="$HOME/majstaf/seznami"
CURRYR=$(date +"%Y")
unset CMMNDS
declare -a CMMNDS

fname_base=commands-history-list-en-by-$(date +"%Y%m%d")
dest_fname=${fname_base}.txt

# 01-COLLECT-ALL-COMMANDS-from-history-en-dat-to-single-file.onl.txt
export LC_ALL=C
printf "[INFO] collecting hstl files into ${fname_temp} ...\n"
readarray -t CMMNDS < <(cat ${SEZNAMI_DIR}/hstl-en-${CURRYR}* | cut -b 28- | sort | uniq -c)

# 02-REMOVE-count-nums-infront-of-commands-in-single-file.onl.txt
# VERY SLOW BECAUSE EXTERNAL CMMANDS RUN ON EVERY LINE IN FOR LOOP!!!
printf "[INFO] cleaning final ${dest_fname} ...\n"
for LINE in "${CMMNDS[@]}"; do
	echo "${LINE}" | \
	cut -b 9- | \
	grep -v -f "${SRCDIR}/excludes-hstl-en.txt"
done > ${SEZNAMI_DIR}/${dest_fname}
printf "[INFO] done\n"

