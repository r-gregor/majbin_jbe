#! /usr/bin/env bash

grep bindsym ~/.config/i3/config | grep -v "#" | rofi -dmenu -p '' &> /dev/null &

