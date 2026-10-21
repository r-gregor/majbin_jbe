#! /usr/bin/env bash
# fname: fsplit.sh
# descpt: split file into n-parts files
# 20260929 v1
# last: 20260929
# ---

PARTS=2
ARGS=("$@")
NUMARGS="${#ARGS[*]}"

case "$NUMARGS" in

	1)
		fname="${ARGS[0]}"
	;;

	2)
		fname="${ARGS[0]}"
		PARTS="${ARGS[1]}"
	;;

	*)
		printf "[e] no filename supplied\n"
		printf "Usage: $0 <fname> <n>\n"
		printf "           fname: file name\n"
		printf "           n:     number of parts to split fname into\n"
		printf "                  if only <filename> supiplied: n = 2\n"
		printf "\n"
		exit 1
	;;
esac

if [ ! -f "$fname" ]; then
	printf "[e] NO such file: '%s'\n"  "$fname"
	exit 1
fi

printf "[i] command: "
printf "split -n ${PARTS} -d ${fname} ${fname}_part-\n"
read -r -p "[?] continue?"
split -n "${PARTS}" -d "${fname}" "${fname}_part-"

