#! /usr/bin/env bash

gDest="/media/rgregor/B1_2_EXT4/backup_jbez0rg/OLDHDD_old-home/rgregor/"
sudo rsync -n -av --delete --progress /home/rgregor/OLDHDD/old_home/rgregor/ ${gDest}/

