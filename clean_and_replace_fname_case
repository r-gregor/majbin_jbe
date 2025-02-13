#! /usr/bin/env bash

# clean_and_replace_fname_case
# changes all letters to LOWERCASE

if [ $# -ne 1 ]; then
	echo "usage: clean_and_replace_fname_case [fname]"
	echo -e "\n"
	exit
else
	FFF=$1
fi


echo "Dry run:"
echo mv "\"${FFF}\"" $(echo "${FFF}" | sed \
	-e "s/\s\+/_/g" \
	-e "s/#//g" \
	-e "s/!//g" \
	-e "s/|//g" \
	-e "s/｜//g" \
	-e "s/：//g" \
	-e "s/\+//g" \
	-e "s/(//g" \
	-e "s/)//g" \
	-e "s/\[//g" \
	-e "s/\]//g" \
	-e "s/,/_/g" \
	-e "s/<//g" \
	-e "s/>//g" \
	-e "s/://g" \
	-e "s/;//g" \
	-e "s:\&:-and-:g" \
	-e "s/_-_/-/g" \
	-e "s/_\{2,\}/_/g" \
	| tr '[:upper:]' '[:lower:]' \
)

read -p "Continue?"

mv -v "${FFF}" $(echo "${FFF}" | sed \
	-e "s/\s\+/_/g" \
	-e "s/#//g" \
	-e "s/!//g" \
	-e "s/|//g" \
	-e "s/｜//g" \
	-e "s/：//g" \
	-e "s/\+//g" \
	-e "s/(//g" \
	-e "s/)//g" \
	-e "s/\[//g" \
	-e "s/\]//g" \
	-e "s/,/_/g" \
	-e "s/<//g" \
	-e "s/>//g" \
	-e "s/://g" \
	-e "s/;//g" \
	-e "s:\&:-and-:g" \
	-e "s/_-_/-/g" \
	-e "s/_\{2,\}/_/g" \
	| tr '[:upper:]' '[:lower:]' \
)

