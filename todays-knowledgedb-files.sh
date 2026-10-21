#! /usr/bin/env bash
# fname: todays-knowledgedb-files.sh
# descpt: fzf-find todays files from $KNOWLEDGEDB and open them in vim (read-only)
# 20261006 v1
# 20261013 v2 make it universal
# 20261021
# last: 20261021
# ---

# === GLOBALS ===
unset list
list=()
TODAY=$(date +"%Y%m%d")
NOW=$(date +"%H")
SRCDIR="${KNOWLEDGEDB:-/home/gregor.redelonghi/majstaf/engit/knowledgedb}"

# === MAIN ===
if [ $# -eq 1 ]; then
	HR="$1"
	DEJT="${TODAY}"
	if [ $(( "${NOW}" - "${HR}" )) -le 0  ]; then
		printf "[e] out of time range\n\n"
		exit 1
	fi
elif [ $# -eq 2 ]; then
	DEJT="$1"
	HR="$2"
	if [ $(( "${DEJT}" - "${TODAY}" )) -gt 0 ]; then
		printf "[e] wrong date\n\n"
		exit 1
	fi

	if [ $(( "${TODAY}" - "${DEJT}" )) -gt 0 ]; then
		NOW=24
	fi

	if [ $(( "${NOW}" - "${HR}" )) -lt 0  ]; then
		printf "[e] out of time range\n\n"
		exit 1
	fi
else
	HR=8
	DEJT="${TODAY}"
fi

if [ "${HR}" -lt 10 ]; then
	HR="0${HR}"
fi

printf "\n[i] getting today's entries:"
printf "\tin '%s'\n" "${SRCDIR}"
printf "\tafter: ${HR}:00:00 on %s\n" "${DEJT}"

read -r -p "[?] continue? (y/Y)" ans

if [ ! "${ans}" == "Y" ] && [ ! "${ans}" == "y" ]; then
	printf "\n"
	exit 1
fi

readarray -t -O "${#list[@]}" list < <(find "${SRCDIR}" -newermt "${DEJT} ${HR}:00:00" -type f | grep -v '\.git')

if [ "${#list[@]}" -le 0 ]; then
	printf "[e] no files found\n\n"
	exit 1
fi

fjls=$(for (( i=0; i < "${#list[@]}"; i++ )); do
	echo "${list[$i]}"
done | fzf -m --reverse)

if [ "${fjls[0]}" == "" ]; then
	printf "[e] no files selected\n\n"
	exit 1
fi

for FJL in "${fjls[@]}"; do
	echo "${FJL}"
done | xargs -ro vim -pM

printf "\n"

