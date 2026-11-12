#! /usr/bin/env bash
# fname: gt-fetch-branch-vv.sh
# descpt: 'git fetch' and 'git branch -v -v' command to se if HEAD behind/ahead the remote
# 20261109 v1
# last: 20261109
# ---
git fetch && git --no-pager branch -v -v

