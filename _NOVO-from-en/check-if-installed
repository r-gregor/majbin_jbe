#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	cmnd="$1"
else
	echo "Usage: test_if_installed <cmnd_name> ... (usig 'git'):"
	cmnd="git"
fi

green="\e[1;32m"
red="\e[1;31m"
off="\e[0m"

# if ! command -v $cmnd &>/dev/null; then echo "'$cmnd' is NOT installed!"; else echo "'$cmnd' IS installed."; fi
if ! command -v $cmnd &>/dev/null; then
	echo -e "-->\t${red}'$cmnd' is NOT installed!${off}"
else
	echo -e "-->\t${green}'$cmnd' IS installed.${off}"
fi


#	$> cat test_if_installed.sh; for cmnd in git bash numpy firefox lalali; do ./test_if_installed.sh $cmnd; done
#	#! /usr/bin/env bash
#	
#	if [ $# -eq 1 ]; then
#			cmnd="$1"
#	else
#			cmnd="git"
#	fi
#	
#	if ! command -v $cmnd &>/dev/null; then echo "'$cmnd' is NOT installed!"; else echo "'$cmnd' IS installed."; fi
#	'git' IS installed.
#	'bash' IS installed.
#	'numpy' is NOT installed!
#	'firefox' is NOT installed!
#	'lalali' is NOT installed!
