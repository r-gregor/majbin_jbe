#! /usr/bin/env bash

expected_node="muadib"
current_node="$(uname -n)"

gDest="/media/rgregor/E75F-1AEC/backup_${expected_node}"

if [ "${expected_node}" != "${current_node}" ]; then
	echo "[ERROR] Wrong host name (${current_node}). It should be: ${expected_node}"
	exit
fi

sync_to_exfat='sudo rsync -hvrltD --modify-window=1 --no-links --info=skip0 '
#sudo rsync -n -av --delete --progress \
${sync_to_exfat} -n --delete --progress \
	--exclude SLIKE/ \
	--exclude=".cache/" \
	--exclude="*cache/" \
	--exclude="*Cache/" \
	--exclude=".thumbnails/" \
	--exclude="majstaf/majmedia/Movies" \
	--exclude="majstaf/majmedia/Seivom" \
	/home/ ${gDest}/home/ \
	| grep -vi "skipping non-regular file\|failed: Invalid argument"

