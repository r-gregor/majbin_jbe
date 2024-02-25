#! /bin/bash

# change: 20150310
# change: 20200308:	- display only basename of ~/.local/bin/[filename]
#					- sorted output by ~/.local/bin/[filename]


clear
echo "List of \"soft-linked\" scripts in ~/.local/bin:"
echo

for aaa in $(find ~/.local/bin -type l); do
	F1=$(basename "${aaa}")
	F2=$(ls -lgG "${aaa}" | awk '{print $9}')
    printf "%-50s%s\n" $F1 $F2 | tr ' ' '.'
done | sort
echo
 
