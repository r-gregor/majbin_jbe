#! /usr/bin/env bash

/usr/bin/grep 'bindsym' ~/.config/i3/config | grep -v "#" | rofi -dmenu -p '' &>/dev/null &

