#! /usr/bin/env bash
# fname: dirs-by-size.sh
# descpt: display all dirs with the size more than 9M
# 20260929 v1
# last: 20260929
# ---

crtc() {
	printf "---\n"
}

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
	if [ "$1" == "-h" ]; then
		usage
		exit 0
	elif [ "$1" == "-a" ]; then
		long=1
		printf "[i] Directories by size (all sizes):\n"
		crtc
	else
		long=0
	fi
else
	printf "[i] Directories by size (at least 10 MB):\n"
	crtc
fi

if [ "$long" -eq 0 ]; then
	find * -maxdepth 0 -type d -print0 | xargs -0 du -sh --total | sort -hr | grep -E "^[0-9][.,]*[0-9]{1,2}G|^[0-9]{2,3}M"
else
	find * -maxdepth 1 -type d -print0 | xargs -0 du -sh --total | sort -hr
fi

