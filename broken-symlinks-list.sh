#! /usr/bin/env bash
# fname: broken-symlinks-list.sh
# descpt: list broken simlinks in '~/.local/bin'
# 20261008 v1
# last: 20261008
# ---

# === GLOBALS ===
SRCD="${HOME}/.local/bin"

# === MAIN ===
find "${SRCD}"/* -print0 | xargs -0 file | grep -i "broken "
printf "\n"



