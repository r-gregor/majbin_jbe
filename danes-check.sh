#! /usr/bin/env bash
# fname: danes-check.sh
# descpt: Checks if any files left in '~/majstaf/_NERAZPOREJENO/__DANES__'
# 20260929 v1
# last: 20260929
# ---


dest="${HOME}/majstaf/_NERAZPOREJENO/__DANES__"
mcmd="${HOME}/.local/bin/check4emptyd"

result=$(${mcmd} "${dest}")

echo "${result}" | grep NOT &>/dev/null

if [ $? -eq 0 ]; then
	result="${result//INFO/WARN}"
fi

echo "${result}"
echo

