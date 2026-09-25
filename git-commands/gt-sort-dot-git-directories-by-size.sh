#! /usr/bin/env bash
# filename: gt-sort-dot-git-directories-by-size.sh
# descpt: Sort .git repositories by size
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

for DDD in $(find -type d -name "\.git"); do du -sh $DDD; done | sort -hr

