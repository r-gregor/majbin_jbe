#! /usr/bin/env bash
# filename: hstl-mdb.sh
# 20251120 v1 create history commands snapshot
# last: 20251120
# ---

shopt -s histappend
HISTFILE=~/.bash_history
HISTCONTROL=erasedups
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=5000
export HISTTIMEFORMAT='%F %T '

HNML=muadib

HSTL_PATH="$HOME/majstaf/seznami/hstl-${HNML}-$(date +'%Y%m%d-%H%M%S').txt"
set -o history
history -r
history -a
history -w
history >> ${HSTL_PATH}
set +o history
echo "Sccesfully added commands from HISTORY to ${HSTL_PATH}"

