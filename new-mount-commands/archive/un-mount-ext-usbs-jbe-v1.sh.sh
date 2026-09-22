#! /usr/bin/env bash
#v1

unset usbs
usbs=()

readarray -t usbs < <(lsblk | grep -E 'sd.[0-9]' | grep -v 'sda' | sed 's/.*\(sd.[0-9]\).*/\1/')

if [ ${#usbs[@]} -eq 0 ]; then
	echo -e "[ERROR] No externa USB-s plugged\n"
	exit
fi

for (( i=0; i<${#usbs[$i]}; i++)); do
	PART=${usbs[$i]}
	# TEST
	echo "sudo sync" && echo "UN-mounting ... /dev/${PART}" && echo "udisksctl unmount -b /dev/${PART}"

	#RUN
	# sudo sync && echo "UN-mounting ... /dev/${PART}" && udisksctl unmount -b /dev/${PART}
done

