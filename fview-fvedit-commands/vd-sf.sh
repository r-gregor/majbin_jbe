#! /usr/bin/env bash
# fname: ve-s
# pipe output of external command into ve-
# 20260402
# last: 20260402
# ---

fzf --reverse | xargs -ro vim

