#! /usr/bin/env bash
# filename: collect_hstl.sh
# v1_20251120 collect and filter out all history snapshots till today
# v2_20260605 fname (base, temp, dest) variables
# last: 20260605
# ---

SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
CURRYR=$(date +"%Y")

fname_base=commands-history-list-en-by-$(date +"%Y%m%d")
fname_temp=${fname_base}_temp.txt
dest_fname=${fname_base}.txt
touch ${fname_temp}

# 01-COLLECT-ALL-COMMANDS-from-history-en-dat-to-single-file.onl.txt
export LC_ALL=C
# cat $HOME/majstaf/seznami/hstl-en-${CURRYR}* | cut -b 28- | grep -v -f "${SRCDIR}/excludes-hstl.txt" | sort | uniq -c >> ${fname_base}.txt
printf "[INFO] collecting hstl files into ${fname_temp} ...\n"
cat $HOME/majstaf/seznami/hstl-en-${CURRYR}* | cut -b 28- | sort | uniq -c >> ${fname_temp}

# 02-REMOVE-count-nums-infront-of-commands-in-single-file.onl.txt
# cat commands-history-list-en-by-$(date +"%Y%m%d").txt | cut -b 9- > commands-history-list-en-by-$(date +"%Y%m%d")-2.txt
printf "[INFO] cleaning final ${dest_fname} ...\n"
cat ${fname_temp} | cut -b 9- > ${dest_fname}
printf "[INFO] done\n"


