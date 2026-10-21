#! /usr/bin/env bash
# fname: vv-sfe.sh
# descpt: view fzf-sellected (-e) file in vim
# v1_20260402
# last: 20260402
# ---

fzf --reverse -e | xargs -ro vim -M

