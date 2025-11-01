#! /bin/bash

### Name:	Scriptname ...
### Author:	Author ... 
### Date:	2013-05-24 
### Decription:
### 
### 
### 
 
# Check if parameter is set and if it is in yyyymmdd format (8 chars)
# if not: display usage ...

if [ $# -ne 1 ]  || [ ${#1} -ne 8 ]; then
	echo
	echo -e "Usage: ${0} [yyyymmdd]\n"
	exit 1
fi

GR_DEJT=$1

clear

# ---
# echo
# echo "Entered date: $GR_DEJT"
# read -p "OK? Any key to proceed or ctrl-c to quit"

GR_DBOT="$HOME/Dropbox/ODPRTO/_TXT/"

# ---
# echo
# echo "cd-ing to $GR_DBOT ..."
cd $GR_DBOT
# echo "We are in: $PWD"
# read -p "OK? Any key to proceed or ctrl-c to quit"
# 
# ---
echo
echo "----------------------------------"
echo "Listing files newer than $GR_DEJT:"
echo "----------------------------------"
for AAA in $(for FFF in $(ls -1 | grep -oE '[[:digit:]]{8}'); do echo $FFF; done | sort -n | uniq); do if [ $AAA -gt $GR_DEJT ]; then ls -1 *${AAA}*; fi ; done
echo

