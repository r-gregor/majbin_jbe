#! /usr/bin/env bash
# fname: fview-fvedit-commands/vv-mf.sh
# descpt: open multiple fzf-sellected files in vim
# v1_20260402
# last: 20260402
# ---

fzf --reverse -m | xargs -ro vim -M

