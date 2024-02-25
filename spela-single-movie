#! /bin/bash

if [ $# -ne 1 ]; then
	echo "You must supply a movie filename!"
	exit 1
fi

MV=$(realpath "$1")
echo "TEST: $MV"

sudo ln -sv "$MV" /home/spela/Movies/
