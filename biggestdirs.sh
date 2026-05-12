#! /bin/bash

### clear the screen and display biggest dirs
### under current dir ...

clear # clear the screen ...

if [ ! $1 ]; then		# if commandline argument is NOT set ...
	echo "usage: biggestdirs [linesnum] ... (default=30)" 
	echo -en "Enter linesnum or hit <ENTER> to skip:  "
	read gr_vnos		# read value
	gr_linesnum=${gr_vnos:-30}	# if no value is entered, it defaults to 30 ...
else				# if commandline argument IS SET ...
	gr_linesnum=$1
fi


# if currdir is a SYMLINK, convert it to absolute path ...
if [ -L $PWD ]; 
	then gr_POT=$(readlink $PWD)
	else gr_POT=$PWD
fi

# run command ...
clear; echo; for FFF in $(find ${gr_POT} -maxdepth 1 -type d -iname "*"); do du -sh $FFF 2> /dev/null; done | sort -hr | head -n ${gr_linesnum} | cat -n

