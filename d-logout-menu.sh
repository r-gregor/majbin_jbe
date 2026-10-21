#! /usr/bin/env bash

choice=$(echo -e "logout\nreboot\nshutdown" | dmenu -l 3 -p "logout/power off >")

case $choice in
	logout)
		sudo loginctl terminate-user ${USER}
		;;
	
	reboot)
		sudo reboot
		;;
	
	shutdown)
		echo sudo systemctl poweroff
		;;

	*)
		exit
	;;
esac


