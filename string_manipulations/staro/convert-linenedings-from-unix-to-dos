#! /bin/bash

### Name:   Scriptname ...
### Author: Author ... 
### Date:   2013-05-24 
### Decription:


# 20141027 IFS value settings
# set IFS to newline '\n'

# curryr=2021

if [ $CURRENT_YEAR_ENV -ne $(date +%Y) ]; then
		curryr=$CURRENT_YEAR_ENV
	else
		curryr=$(date +%Y)
fi

nifs()	{
	echo -n "setting IFS to newline ..." 
	IFS=$'\n'
	echo " done."
}

# set IFS to orginal ' \t\n'
oifs()
	{
	echo -n "setting IFS to original value ..."
	IFS=$' \t\n'
	echo " done."
	}


nifs

for FFF in $(find /c/Users/gregor.redelonghi/${curryr} -type f -name "*\.txt"); do unix2dos $FFF; done

oifs

