#! /usr/bin/env bash
# fname: read-latest-from-knowledgedb.sh
# descpt: read/view todays files from $KNOWLEDGEDB from hour/12
# 20261021
# last: 20261021
# ---

#! /usr/bin/env bash

DANES=$(date +"%Y%m%d")
ZDAJ=$(date +"%H")
URA=12
SRC="${KNOWLEDGEDB:-/home/gregor.redelonghi/majstaf/engit/knowledgedb}"


if [ $# -eq 1 ]; then
	if [ $((${ZDAJ} - $1)) -le 0  ]; then
		printf "[E] out of time range\n"
		exit 1
	fi
	URA="$1"
fi

printf "\n[i] getting today's entries:\n"
printf "\tin \"${SRC}\"\n"
printf "\tafter: ${URA}:00:00 on ${DANES}\n"
read -r -p "[?] continue?\n"

find "${SRC}" -newermt "${DANES} ${URA}:00:00" -type f | grep -v '\.git' | fzf -m --reverse | xargs -ro vim -pM


