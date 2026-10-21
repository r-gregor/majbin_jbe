#! /usr/bin/env bash
# fname: ve-me
# descpt: open fzf-selected (-e) file in vim
# v1_20260402
# last: 20260402
# ---

fzf --reverse -m -e | xargs -ro vim

