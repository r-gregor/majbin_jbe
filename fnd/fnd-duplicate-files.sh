#! /bin/bash
# fname: find-duplicatef-01.sh
# descpt: find non-empty duplicate files
# v1_20140420
# ONELINER that finds all duplicate files (by contents) in groups separated ba empty lines ...
#---

find -not -empty -type f -exec md5sum {} \; 2>/dev/null | sort -rn | uniq -w 32 --all-repeated=prepend | cut -d '*' -f2

