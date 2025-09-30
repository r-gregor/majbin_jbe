#! /usr/bin/env bash

# timestamp
tms() {
	echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}

# crtice
crtn=70
crtc() {
	if [ $# -ne 1 ]; then
		echo "---"
	else
		for ((i=1; i<=$1; i++)); do
			echo -n "-"
		done
		echo
	fi
}

# usage
usage() {
cat <<EOF
    Usage:
    $0 [arg]
    - arg:  none --> display all dirs with the size more than 9M
            -h   --> display this usage
            -a   --> display all dirs no matter the size

EOF
}

long=0

if [ $# -ne 0 ]; then
	if [ $1 == "-h" ]; then
		usage
		exit 0
	elif [ $1 == "-a" ]; then
		long=1
		tms; echo "Directories by size (all sizes):"
		crtc
	else
		long=0
	fi
else
	tms; echo "Directories by size (at least 10 MB):"
	crtc
fi

if [ $long -eq 0 ]; then
	sudo find * -maxdepth 0 -type d -print0 | xargs -0 sudo du -sh --total | sort -hr | grep -E "^[0-9][.,]*[0-9]{1,2}G|^[0-9]{2,3}M"
else
	sudo find * -maxdepth 1 -type d -print0 | xargs -0 sudo du -sh --total | sort -hr
fi

