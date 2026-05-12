#! /bin/bash

### Name:	string-to-lower-with-hypens.sh
### Author:	RgregoR
### Date:	2022-10-10
### Decription:	converts string from parameter to lowercase, spaces replaced with hypens
### 
### 
### 
 
if [ $# -eq 1 ]; then
	gr_FJLNM="$1"
else 
	read -p "Enter the filename with uppercase letters and/or spaces: " gr_FJLNM
fi

echo "Converting filename to loweracse with hypens inplace of spaces ..."
gr_FJLNMC=$(echo ${gr_FJLNM} |  tr '[:upper:]' '[:lower:]' | sed -e 's/: */_/g' -e 's/,//g' | tr ' ' '-')

echo
echo ${gr_FJLNMC} | sed 's/"//g'
echo

