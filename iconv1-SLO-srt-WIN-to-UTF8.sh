#! /usr/bin/env bash
# descpt: convert srt file encoding from WIN-1250 to utf-8
# 20190407
# last: 20190407
# ---

if [ $# -ne 1 ]; then
    printf "[e] no <filename.srt> to be converted as argument\n\n"
    exit 1
else
    FJL="$1"
fi

printf "[i] converting '%s' from WINDOWS-1250 to utf-8 ...\n" "${FJL}"
iconv -f WINDOWS-1250 -t utf-8 "$PWD"/$FJL > "$PWD"/SLO-UTF8.srt
printf "[i] exported to SLO-UTF8.srt ...\n"
printf "[i] done\n\n"

