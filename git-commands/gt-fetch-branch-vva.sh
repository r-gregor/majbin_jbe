#! /usr/bin/env bash
# fname: gt-fetch-branch-vva.sh
# descpt: 'git fetch' and 'git branch -v -v -a' command to se if HEAD behind/ahead the remote
# 20261109 v1
# last: 20261109
# ---
git fetch && git --no-pager branch -v -v -a

