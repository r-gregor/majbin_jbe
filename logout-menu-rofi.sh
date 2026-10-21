#! /usr/bin/env bash

choice=$(echo -e "logout\nreboot\nshutdown\nquit" | rofi -dmenu -no-fixed-num-lines)

case $choice in
	logout)
		sudo loginctl terminate-user ${USER}
		;;
	
	reboot)
		sudo reboot
		;;
	
	shutdown)
		sudo systemctl poweroff
		;;

	quit)
		exit
		;;

	*)
		exit
	;;
esac


