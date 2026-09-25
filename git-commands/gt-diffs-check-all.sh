#! /usr/bin/env bash
# filename: gt-diffs-check-all.sh
# descpt: Run git-diffs on multiple dirs
# 20260921
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

for DDD in majbin majrcs metsys; do
	gt-check-git-diffs "$DDD";
done

