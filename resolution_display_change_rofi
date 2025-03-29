#! /usr/bin/env bash

scale_normal="scale: 1.0x1.0 (normal)"
scale_16="scale: 1.6x1.6 (3072x1728)"
scale_20="scale: 2.0x2.0 (3840x2160)"

choice=$(echo -e "${scale_normal}\n${scale_16}\n${scale_20}" \
	| rofi -dmenu -no-fixed-num-lines)


case $choice in
	"${scale_normal}")
		# echo "xrandr --output HDMI-2 --mode 1920x1080 --scale 1x1 --fb 1920x1080"
		xrandr --output HDMI-2 --mode 1920x1080 --scale 1x1 --fb 1920x1080
	;;

	"${scale_16}")
		# echo "xrandr --output HDMI-2 --mode 1920x1080 --scale 1.6x1.6 --fb 3072x1728"
		xrandr --output HDMI-2 --mode 1920x1080 --scale 1.6x1.6 --fb 3072x1728
	;;

	"${scale_20}")
		# echo "xrandr --output HDMI-2 --mode 1920x1080 --scale 2x2 --fb 3840x2160"
		xrandr --output HDMI-2 --mode 1920x1080 --scale 2x2 --fb 3840x2160
	;;
esac

# 
# xrandr --output HDMI-2 --mode 1920x1080 --scale 1.6x1.6 --fb 3072x1728
# xrandr --output HDMI-2 --mode 1920x1080 --scale 2x2 --fb 3840x2160
# xrandr --output HDMI-2 --mode 1920x1080 --scale 1x1 --fb 1920x1080
