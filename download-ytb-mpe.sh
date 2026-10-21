#! /usr/bin/env bash
# fname: download-ytb-mpe.sh
# descpt: download mp3 from Youtube URL
# 20260929 v1
# last: 20260929
# ---

if [ $# -ne 1 ]; then
	echo -e "Usage: $0 <youtube with music URL>\n"
	exit
fi

URL=$1
yt-dlp --proxy $PRXY -x --audio-format mp3 "${URL}"

