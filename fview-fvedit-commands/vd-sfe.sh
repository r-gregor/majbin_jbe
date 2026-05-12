#! /usr/bin/env bash
# fname: ve-se
# pipe output of external command into ve-se
# 20260402
# last: 20260402
# ---

fzf --reverse -e | xargs -ro vim

