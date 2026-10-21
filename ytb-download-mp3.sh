#! /usr/bin/env bash
#! /usr/bin/env bash
# fname: ytb-download-mp3.sh
# descpt: download 'mp3' file from 'youtube-video'
# 20261021
# last: 20261021
# ---

# === MAIN ===
if [ $# -ne 1 ]; then
	printf "[e] usage: ytb-download-mp3 <youtube with music URL>\n\n"
	exit 1
fi

URL="$1"
yt-dlp --proxy $PRXY -x --audio-format mp3 "${URL}"

printf "\n"

