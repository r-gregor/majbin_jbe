#! /usr/bin/env bash
# fname: shorten-movie-name.sh
# descpt: shorten movie name to format: 'Somer.Movier.Name.{mp4,mkv,avi,srt,...}'
# 20261002 v1
# last: 
# ---

# set IFS to newline '\n'
nifs() {
	IFS=$'\n'
}

# set IFS to orginal ' \t\n'
oifs() {
	IFS=$' \t\n'
}

nifs

for FFF in $(find . -type f -name "*.mp4" -o -name "*.mkv" -o -name "*.avi" -o -name "*.srt" | grep -v "EN"); do echo mv -v "${FFF}" $(echo "${FFF}" | sed 's/\(.*\.[12].\{3\}\.\).*\(.\{3\}$\)/\1\2/'); done

read -r -p "[?] OK? Press any key to continue and <ctrl+c> to quit!"
for FFF in $(find . -type f -name "*.mp4" -o -name "*.mkv" -o -name "*.avi" -o -name "*.srt" | grep -v "EN"); do mv -v "${FFF}" $(echo "${FFF}" | sed 's/\(.*\.[12].\{3\}\.\).*\(.\{3\}$\)/\1\2/'); done

oifs

