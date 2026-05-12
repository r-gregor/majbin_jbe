#! /usr/bin/env bash

HISTFILE=~/.bash_history
set -o history

gPth="$HOME/majstaf/seznami/hstld_$(date +'%Y%m%d-%H%M%S').txt"
history >> ${gPth}

echo "Sccesfully added commands from HISTORY to ${gPth}."

