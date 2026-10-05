#! /usr/bin/env bash
# fname: show-vim-mappings.sh
# descpt: show mappings from ~/.vimrc
# 20261002 v1
# last: 20261002
# ---

grep -E -B2 '^.*map ' ~/.vimrc

printf "\n"



