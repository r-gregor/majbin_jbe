#! /usr/bin/env bash

if [ "$(pgrep picom)" != "" ]; then
	printf "[i] not running -- shuting down ...\n"
	sudo killall picom
else
	printf "[i] picom not running \n"
	printf "\n"
	exit
fi
printf "\n"

