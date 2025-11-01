#! /usr/bin/env bash
# 20241127 en

PARTS=2
ARGS=("$@")
NUMARGS=${#ARGS[*]}

# test
# echo "NUM of args: ${#ARGS[*]}"

case $NUMARGS in

	1)
		fname=${ARGS[0]}
	;;

	2)
		fname=${ARGS[0]}
		PARTS=${ARGS[1]}
	;;

	*)
		echo "[ERROR] No filename supplied"
		echo "Usage: $0 <fname> <n>"
		echo "           fname: file name"
		echo "           n:     number of parts to split fname into"
		echo "                  if only <filename> supplied: n = 2"
		echo ""
		exit
	;;
esac

if [ ! $fname ]; then
	echo -e "[ERROR] $fname: No such file\n"
	exit
fi

echo -n "Command: "
echo "split -n ${PARTS} -d ${fname} ${fname}_part-"
read -p "Continue?"
split -n ${PARTS} -d ${fname} ${fname}_part-

