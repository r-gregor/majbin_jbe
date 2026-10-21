#! /usr/bin/env bash
# fname: vd-sfe.sh
# descpt: open fzf-sellected (-e) file in vim
# v1_20260402
# last: 20260402
# ---

fzf --reverse -e | xargs -ro vim

