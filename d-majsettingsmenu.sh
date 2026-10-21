#! /usr/bin/env bash

choice=$(echo -e "nm-connection-editor\npavucontrol\nlxtask\narandr\nsystem-config-printer\nxfce5-settings-manager" | dmenu -l 10 -p "select system action >")


case $choice in
	nm-connection-editor)
		nm-connection-editor 2>/dev/null &
		;;
	
	pavucontrol)
		pavucontrol 2>/dev/null &
		;;
	
	lxtask)
		lxtask 2>/dev/null &
		;;
	
	arandr)
		arandr 2>/dev/null &
		;;
	
	system-config-printer)
		system-config-printer 2>/dev/null &
		;;
	
	xfce4-settings-manager)
		xfce4-settings-manager 2>/dev/null &
		;;
	
	*)
		echo -e "Not a valid choice\n"
		exit
		;;
esac










# nm-connection-editor
# pavucontrol
# lxtask
# arandr
# system-config-printer
# xfce4-settings-manager
