#! /usr/bin/env bash

if [ "$(pgrep picom)" != "" ]; then
	printf "[INFO] not running -- shuting down ...\n"
	sudo killall picom
else
	printf "[INFO] picom not running \n"
	exit
fi

