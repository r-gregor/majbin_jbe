#! /bin/bash
clear

gr_MSG="Usage: $0 [ , < path >, -h ]"

if [ $# -eq 1 ]; then
	gr_LCT=$1
else
	gr_LCT="$PWD"
fi

if [ ! -e ${gr_LCT} ]; then
	echo "The path supplied is NONEXISTANT! Exiting. Bye!"
	exit 1
fi
	

clear
echo -e "Finding [ latest ...txt ] files, sorted by date ..."
echo -e "\nSerch start location is: \n\t${gr_LCT}\n"
	
	# command:
	find ${gr_LCT} -type f -iname "*txt" -exec ls -lgG --time-style=long-iso {} \; 2>/dev/null | cut -d' ' -f4- | sort -nr | head -n50
	if [ $? -ne "0" ]; then
		echo "Something went WRONG. Exiting. Bye!"
	fi
	
echo -e "\nDone."
