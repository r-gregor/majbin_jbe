#! /usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "Must suply a filename!"
    exit 1
fi

fnm=$1

sed -n '/\[[[:digit:]]\{2,3\}\]/p' $fnm | grep -E --color "\[.{2,3}\]"

echo "Remove? [yes|YES] or anything else to terminate ... "
read ANS

if [[ $ANS == "yes" || $ANS == "YES" ]]; then
    sed -i 's/\[[[:digit:]]\{2,3\}\]//g' $fnm
    echo "Done."
else
    echo "No [yes|YES]. Terminating ..."
    echo "Bye!"
fi
