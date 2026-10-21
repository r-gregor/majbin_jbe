#! /usr/bin/env bash
# filename: show-aliases-en.sh
# descpt: Show all aliases from $MRCS
# last: 20260922
# ---

PDD=20
PTH="${HOME}/majstaf/majrcs/aliases-*"

if [ $# -gt 0 ]; then
	pattern="$1"
	shift
	params="$@"
	echo $params
	for param in $params; do
		pattern="$pattern\|$param"
	done

	cmd='cat ${PTH} | \grep "^alias" | sed -e "/^#/d" -e "/^$/d" | sed "s/^alias //" | grep "${pattern}" | sorti | uniq'
else
	cmd='cat ${PTH} | \grep "^alias" | sed -e "/^#/d" -e "/^$/d" | sed "s/^alias //" | sort | uniq'
fi

while read LINE; do
	alias_name=$(echo $LINE | cut -d'=' -f1)
	alias_value=$(echo $LINE | cut -d'=' -f2-)
	printf "%-*s%s\n" ${PDD} "$alias_name" "$alias_value"
done < <(eval "${cmd}")

