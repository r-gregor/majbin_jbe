#! /usr/bin/env bash
# filename: knowledgedb-copy-file-to-category

# globals
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
DEST="/home/rgregor/majstaf/jbegit/knowledgedb"
if [ $# -ne 1 ]; then
	echo -e "usage: $0 <filename>\n"
	exit
else
	fname=$1
fi

if [ ! -f "${fname}" ]; then
	echo -e "[ERROR] No such file: ${fname}\n"
	exit
fi

CATEGORY=$(ls -1 ${DEST} | fzf -e --reverse)

echo -n "Copy \"${fname}\" to .../${CATEGORY}? [y/n]:  "
read -r ans

if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
	cp -iv ./"${fname}" "${DEST}/${CATEGORY}/"
else
	echo -e "[INFO] No files moved\n"
	exit
fi

echo ""

