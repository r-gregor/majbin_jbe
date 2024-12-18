#! /usr/bin/env bash

gDest="/media/*/B1_2_EXT4/backup_jbez0rg"

sudo rsync -av --delete --progress \
	--exclude SLIKE/ \
	--exclude=".cache/" \
	--exclude="*cache/" \
	--exclude="*Cache/" \
	--exclude=".thumbnails/" \
	--exclude="majstaf/majmedia/Movies" \
	/home/ ${gDest}/home/

