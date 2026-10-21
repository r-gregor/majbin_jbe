#! /usr/bin/env bash

torent_dir="/home/rgregor/majstaf/majmedia/_yts_torrents"

if [ ! $PWD == ${torent_dir} ]; then
	echo -e "[e] must be in \"${torent_dir}\"\n"
	echo
	exit
fi

while read MV; do grep --color "$MV" ../_DOWNLOADED_MOVIES.txt; done < <(ls -1 | grep -v NOVO | sed 's/ \[.*//')

