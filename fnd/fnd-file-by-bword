#! /bin/bash

### Name:	find-file-by-word.sh
### Author:	RgregoR
### Date:	2016-04-18 (20160419,)
### Descr.:	find file by containing (whole) word like: grep, sed, ubuntu, 2016 ...
### 
### -----------------------------------------------------------------------------------
#### UPDATE-1 (20160819-en):
### added test if search pattern suplied as parameter to scritp, else ask for it ...
### -----------------------------------------------------------------------------------
### UPDATE-2 (20160819-en):
### change grep expression from "\b${gr_WRD}\b" to "${gr_WRD}\w*"
### (it searches fort the part of the word too)
### -----------------------------------------------------------------------------------

clear
echo "$(basename $0): FINDING FILES BY CONTAINING WORD"

if [ $# -eq 1 ]; then
	gr_WRD=$1
else
	echo -n "Enter the search (whole) word: "
	read gr_WRD
fi

# find -iname "*${gr_WRD}*" 2>/dev/null | grep --color "\b${gr_WRD}\b"
find -iname "*${gr_WRD}*" 2>/dev/null | grep --color "\b${gr_WRD}"

if [ $? -eq 0 ]; then
	echo -e "\nDone."
else
	echo "Something went wrong, or search pattern was not found ..."
	exit 1
fi

