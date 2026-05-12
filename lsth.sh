#! /usr/bin/env bash
# fname: lsth
# 20260126 d: added optarg for path and number
# last: 20260126
# ---

NUM=15
DEST="."

while getopts 'p:n:h' opt; do
	case "${opt}" in
		p) DEST="${OPTARG}";;
		n) NUM="${OPTARG}";;
		h) cat <<"EOF"
Usage: lsth -[p, n, h]
	-p ... PATH
	-n ... number of files
	-h ... this help message

	if no argument: current dir and max 15 files

EOF
	exit;;
	esac
done

/usr/bin/ls --color=always -t "${DEST}" | head -n "${NUM}"

