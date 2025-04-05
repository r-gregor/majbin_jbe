#! /usr/bin/env bash

dest="${HOME}/_NERAZPOREJENO/__DANES__"
mcmd="${HOME}/.local/bin/check4emptyd"

COLOR_RED="\e[1;31m"
COLOR_RESET="\e[0m"

result=$(${mcmd} ${dest})

echo "${result}" | grep NOT &>/dev/null

if [ $? -eq 0 ]; then
	printf "${COLOR_RED}"
fi

echo "${result}"
printf "${COLOR_RESET}"

