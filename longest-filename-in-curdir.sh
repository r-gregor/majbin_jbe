#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	place=$1
else
	place="."
fi

N=0
for FJL in ${place}/*; do
	FFF=$(basename ${FJL})
	SF=${#FFF}
	if [ ${SF} -gt $N ];then
		N=${SF}
		biggestf=$FFF
	fi
done

# printf "file with max letters [%d]\n" "${N}"
# printf "in:                   [%s]\n" "${place}"
# printf "is:                   [%s]\n\n" "${biggestf}"
# echo "---"
# echo

printf "longest filename [%d] in [\"%s\"]\n" "${N}" "${place}"
printf "is: \"%s\"\n" "${biggestf}"
echo "---"

