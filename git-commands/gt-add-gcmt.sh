#! /usr/bin/env bash
# filename: gt-add-gcmt.sh
# descpt: Auto-run git-add and git-commit with timestamp
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

gcmd="/usr/bin/git add --verbose ."
gcmt="${HOME}/.local/bin/gt-commit-timestamp"

# display commands
printf "running: ${gcmd}\n" && ${gcmd}
printf "\n"
printf "running: ${gcmt}\n" && ${gcmt}

