#! /bin/bash

### script that echoes list of 50 biggets dirs/files
### in sorted order by filesize


if [ -L $PWD ]; 
	then gr_POT=$(readlink $PWD)
	else gr_POT=$PWD
fi


clear && du -ah ${gr_POT} | sort -hr | head -n50 | cat -n
echo

