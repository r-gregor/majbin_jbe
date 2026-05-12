#! /usr/bin/env bash

i3config=~/.config/i3/config
clear
echo -e "i3 key bindings from '${i3config}':\n---"
grep bind "${i3config}" | cut -d' '  -f2- | grep -v "#\|workspace\|XF\|focus\|move"
echo "---"
