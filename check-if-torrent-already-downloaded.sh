#! /usr/bin/env bash
# fname: check-if-torrent-already-downloaded.sh
# descpt: check if torrent files in _yts_torrents or subdirs alreadi in _DSVM.txt file
# 20261114 v2
# last: 20261114
# ---


# === GLOBALS ===
torent_dir="${HOME}/majstaf/majmedia/_yts_torrents"
unset found_torrents
unset downloaded_torrents

declare -a found_torrents
downloaded_torrents="false"

# === MAIN ===
if [ ! $PWD == ${torent_dir} ]; then
	echo -e "[e] must be in \"${torent_dir}\"\n"
	echo
	exit
fi

readarray -t found_torrents < <(find * -iname "*\.torrent" | sed 's/_NOVO\///' | sed 's/ \[.*//')

if [ "${#found_torrents[@]}" -le 0 ]; then
	printf "[!] no torrents found\n\n"
	exit 1
else
	printf "[i] movies not downloaded yet or not updated to _DSVM.txt:\n"
	for torrent in "${found_torrents[@]}"; do
		unset found
		found=0
		while read -r MV; do
			if [[ "${torrent,,}" == "${MV,,}" ]]; then
				((found++))
				downloaded_torrents="true"
			else
				continue
			fi
		done < ../_DSVM.txt
		if [ $found -eq 0 ]; then
			printf "   '%s'\n" "${torrent}"
		else
			continue
		fi
	done
	if [[ "${downloaded_torrents}" == "false" ]]; then
		printf "[i] movies to download or to update _DSVM.txt:\n"
		for movie in "${found_torrents[@]}"; do
			printf "   '%s'\n"
		done
	else
		printf "[i] no movies to download or to update to _DSVM.txt\n"
	fi
fi




# while read MV; do grep --color "$MV" ../_DSVM.txt; done < <(ls -1 | grep -v NOVO | sed 's/ \[.*//')
# while read MV; do
# 	grep "$MV" ../_DSVM.txt
# done < <(find _NOVO/ -iname "*\.torrent" | sed 's/_NOVO\///' | sed 's/ \[.*//')

printf "\n"
