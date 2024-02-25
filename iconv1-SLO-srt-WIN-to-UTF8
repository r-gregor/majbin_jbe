#! /usr/bin/env bash
# 20190407

if [ $# -ne 1 ]; then
    echo "The FJL varible is not set!"
    echo "You must add a [filename.srt] to be converted as argument."
    echo "Bye."
    exit
else
    FJL=$1
fi

echo "converting $FJL from WINDOWS-1250 to utf-8 ..."
echo "exported to SLO-UTF8.srt ..."
echo "Done."
iconv -f WINDOWS-1250 -t utf-8 "$PWD"/$FJL > "$PWD"/SLO-UTF8.srt
