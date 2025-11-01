#! /bin/bash

if [ $# -ne 1 ]; then
	echo -e "You must supply a movie filename!\n"
	exit 1
fi

MV=$(realpath "$1")
echo "TEST: $MV"

sudo ln -sv "$MV" /home/spela/Movies/
