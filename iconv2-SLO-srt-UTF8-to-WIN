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

echo "converting $FJL from utf-8 to WINDOWS-1250 ..."
echo "exported to SLO-WIN.srt ..."
echo "Done."
iconv -f utf-8 -t WINDOWS-1250 "$PWD"/$FJL > "$PWD"/SLO-WIN.srt
