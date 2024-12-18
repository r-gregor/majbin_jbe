#! /usr/bin/env bash

# gDest="/media/rgregor/B1_2_EXT4/backup_muadib"
gDest="/media/*/B1_2_EXT4/backup_muadib"

sudo rsync -av --delete --progress \
	--exclude SLIKE/ \
	--exclude=".cache/" \
	--exclude=".thumbnails/" \
	--exclude="majstaf/majmedia/Movies" \
	--exclude="majstaf/majmedia/Seivom" \
	/home/ ${gDest}/home/


