#! /usr/bin/env bash

# eval $(nohup echo -e "nm-connection-editor\narandr\nlxappearance\nsystem-config-printer\nxfce4-settings-manager\nlxtask\npavucontrol" | fzf)
cmd=$(nohup echo -e "nm-connection-editor\narandr\nlxappearance\nsystem-config-printer\nxfce4-settings-manager\nlxtask\npavucontrol\nquit" | rofi -dmenu -no-fixed-num-lines)

if [ $cmd == "quit"]; then
	exit
else
	# nohup $cmd >&/dev/null &
	# nohup $cmd &>/dev/null &
	nohup $cmd </dev/null >/dev/null 2>&1 &
fi
