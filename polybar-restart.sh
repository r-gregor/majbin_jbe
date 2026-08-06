#! /usr/bin/env bash

if [ "$(pgrep polybar)" == "" ]; then
	printf "[INFO] polybar not running -- reloading ...\n"
	/home/rgregor/.config/polybar/launch.sh
else
	printf "[INFO] polybar already running\n"
fi

