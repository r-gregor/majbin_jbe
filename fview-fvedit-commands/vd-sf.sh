#! /usr/bin/env bash
# fname: vd-sf.sh
# descpt: open fzf-sellected file in vim
# v1_20260402
# last: 20260402
# ---

fzf --reverse | xargs -ro vim

