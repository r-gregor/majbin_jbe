#! /usr/bin/env bash
# fname: vv-mfe.sh
# descpt: open multiple fzf-sellected (-e) files in vim
# v1_20260402
# last: 20260402
# ---

fzf --reverse -m -e | xargs -ro vim -M

