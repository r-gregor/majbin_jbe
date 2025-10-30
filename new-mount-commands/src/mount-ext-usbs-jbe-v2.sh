#! /usr/bin/env bash
#v2 20250216_d

unset usbs
usbs=()

# TEST cmd1
# set -x
# readarray -t usbs < <(lsblk | grep -E 'sd.[0-9]' | grep -v 'sda' | sed 's/.*\(sd.[0-9]\).*/\1/')

# cmd2
readarray -t usbs < <(find /dev/disk/by-path -name "*-usb-*part*" -exec readlink -f {} \;)

if [ ${#usbs[@]} -eq 0 ]; then
	echo -e "[ERROR] No externa USB-s plugged\n"
	exit
fi

for (( i=0; i<${#usbs[$i]}; i++)); do
	PART=$(echo ${usbs[$i]} | grep -E "s..[0-9]")
	echo $PART | grep -E "s..[0-9]" 2>&1 >/dev/null

	if [ $? == 0 ]; then
		mount | grep ${PART} 2>&1 >/dev/null
		if [ $? == 0 ]; then
			echo -n "$PART already mounted at: "
			mount | grep ${PART} | cut -d' ' -f3
		else
			# echo udisksctl mount -b ${PART}
			udisksctl mount -b ${PART}
		fi
	fi
done

