#! /usr/bin/env bash

gDest="/media/rgregor/30c6cbae-b667-4505-87e2-1fe81278be05/jbez0rg_backup"


# sudo rsync -rtDv --delete --progress \
sudo rsync -av --delete --progress \
	--exclude SLIKE/ \
	--exclude=".cache/" \
	--exclude="*cache/" \
	--exclude="*Cache/" \
	--exclude=".thumbnails/" \
	--exclude=".icons/" \
	--exclude="majstaf/majmedia/Movies" \
	/home/ ${gDest}/home/

