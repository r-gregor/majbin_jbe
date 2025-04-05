#! /usr/bin/env bash
#v2 2020216_d

unset usbs
unset PART
usbs=()

if [ $# == 1 ]; then
	PART=$1
	mount | grep ${PART} 2>&1 >/dev/null
	if [ $? == 0 ]; then
		echo "un-mounting $PART ... " && echo -e "\tsudo sync ... " && echo -en "\t"
		# echo "udisksctl unmount -b ${PART}"
		udisksctl unmount -b ${PART}*
		exit
	else
		echo "[ERROR] partition $PART NOT mounted"
		exit
	fi
fi

# readarray -t usbs < <(lsblk | grep -E 'sd.[0-9]' | grep -v 'sda' | sed 's/.*\(sd.[0-9]\).*/\1/')
readarray -t usbs < <(find /dev/disk/by-path -name "*-usb-*part*" -exec readlink -f {} \;)

if [ ${#usbs[@]} -eq 0 ]; then
	echo "[ERROR] No externa USB-s plugged"
	exit
fi


for (( i=0; i<${#usbs[$i]}; i++)); do
	PART=$(echo ${usbs[$i]} | grep -E "s..[0-9]")
	echo $PART | grep -E "s..[0-9]" 2>&1 >/dev/null

	if [ $? == 0 ]; then
		mount | grep ${PART} 2>&1 >/dev/null
		if [ $? == 0 ]; then
			echo "un-mounting $PART ... " && echo -e "\tsudo sync ... " && echo -en "\t"
			# echo "udisksctl unmount -b ${PART}"
			udisksctl unmount -b ${PART}
		else
			echo "$PART already un-mounted"
		fi
	fi
done








########################################################
# for (( i=0; i<${#usbs[$i]}; i++)); do
# 	PART=${usbs[$i]}
# 	# TEST
# 	echo "sudo sync" && echo "UN-mounting ... /dev/${PART}" && echo "udisksctl unmount -b /dev/${PART}"
# 
# 	#RUN
# 	# sudo sync && echo "UN-mounting ... /dev/${PART}" && udisksctl unmount -b /dev/${PART}
# done

