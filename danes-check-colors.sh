#! /usr/bin/env bash
# fname: danes-check-colors.sh
# descpt: In COLOURS: Checks if any files left in '~/majstaf/_NERAZPOREJENO/__DANES__'
# 20260929 v1
# last: 
# ---


dest="${HOME}/majstaf/_NERAZPOREJENO/__DANES__"
mcmd="${HOME}/.local/bin/check4emptyd"

COLOR_RED="\e[1;31m"
COLOR_GREEN="\e[1;32m"
COLOR_RESET="\e[0m"

result=$(${mcmd} "${dest}")

echo "${result}" | grep NOT &>/dev/null

if [ $? -eq 0 ]; then
	printf "${COLOR_RED}"
else
	printf "${COLOR_GREEN}"
fi

echo "${result}"
printf "${COLOR_RESET}"

