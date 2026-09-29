#! /usr/bin/env bash

if [ "$(pgrep picom)" == "" ]; then
	printf "[i] picom not running -- reloading ...\n"
	picom --config ~/.config/picom/picom.conf -b;
else
	printf "[i] picom already running\n"
fi
printf "\n"

