#! /usr/bin/env bash
#v1

unset usbs
usbs=()

# set -x
# readarray -t usbs < <(lsblk | grep -E 'sd.[0-9]' | grep -v 'sda' | sed 's/.*\(sd.[0-9]\).*/\1/')

readarray -t usbs < <(find /dev/disk/by-path -name "*-usb-*" -exec readlink -f {} \;)

if [ ${#usbs[@]} -eq 0 ]; then
	echo -e "[ERROR] No externa USB-s plugged\n"
	exit
fi



for (( i=0; i<${#usbs[$i]}; i++)); do
	PART=$(echo ${usbs[$i]} | grep -E "s..[0-9]")
	echo $PART | grep -E "s..[0-9]" 2>&1 >/dev/null

	if [ $? == 0 ]; then
		echo udisksctl mount -b ${PART}
	fi
done

# for PART in sdb1 sdc1 sdd1; do echo udisksctl mount -b /dev/${PART}; done


