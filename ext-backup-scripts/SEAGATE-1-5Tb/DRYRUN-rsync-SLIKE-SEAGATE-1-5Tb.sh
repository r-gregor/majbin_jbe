#! /usr/bin/env bash

gDest="/media/rgregor/B1_2_EXT4/backup_jbez0rg"

sudo rsync -av -n --delete --progress /home/SLIKE/ ${gDest}/home/SLIKE/

