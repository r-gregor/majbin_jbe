#! /usr/bin/env bash
# fname: longest-filename-in-curdir.sh
# descpt: find longest filename in curdir
# 20261001 v1
# last: 20261001
# ---

if [ $# -eq 1 ]; then
	place="$1"
else
	place="."
fi

N=0
for FJL in "${place}/*"; do
	FFF=$(basename "${FJL}")
	SF="${#FFF}"
	if [ "${SF}" -gt "${N}" ];then
		N="${SF}"
		biggestf="${FFF}"
	fi
done

printf "[i] longest filename [%d] in [\"%s\"]\n" "${N}" "${place}"
printf "[i] is: \"%s\"\n" "${biggestf}"
printf --  "---\n"

