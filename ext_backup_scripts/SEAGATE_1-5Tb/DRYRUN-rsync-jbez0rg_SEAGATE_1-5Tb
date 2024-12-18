#! /usr/bin/env bash

gDest="/media/rgregor/B1_2_EXT4/backup_jbez0rg"

sudo rsync -n -av --delete --progress \
	--exclude SLIKE/ \
	--exclude=".cache/" \
	--exclude=".thumbnails/" \
	--exclude="majstaf/majmedia/Movies" \
	/home/ ${gDest}/home/

