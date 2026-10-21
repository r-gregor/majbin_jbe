#! /usr/bin/env bash
# descpt: convert srt file encoding from utf-8 to WIN-1250
# 20190407
# last: 20190407
# ---
# === GLOBALS ===
# === FUNCTIONS ===


# === MAIN ===
if [ $# -ne 1 ]; then
    printf "[e] no <filename.srt> to be converted as argument\n\n"
    exit 1
else
    FJL="$1"
fi

echo "[i] converting $FJL from utf-8 to WINDOWS-1250 ...\n"
printf "[i] converting '%s' from utf-8 to WINDOWS-1250 ...\n" "${FJL}"
iconv -f utf-8 -t WINDOWS-1250 "$PWD"/$FJL > "$PWD"/SLO-WIN.srt
echo "[i] exported to SLO-WIN.srt ...\n"
echo "[i] done\n\n"


