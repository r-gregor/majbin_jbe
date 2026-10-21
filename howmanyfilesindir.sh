#! /usr/bin/env bash

for DDD in $(find -maxdepth 1 -type d); do echo -e "$(find $DDD -type f | wc -l)\t$DDD"; done | sort -nr
