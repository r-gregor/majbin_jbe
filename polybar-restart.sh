#! /usr/bin/env bash

if [ "$(pgrep polybar)" == "" ]; then
	printf "[i] polybar not running -- reloading ...\n"
	/home/rgregor/.config/polybar/launch.sh
	printf "\n"
else
	printf "[i] polybar already running\n"
	printf "\n"
fi

