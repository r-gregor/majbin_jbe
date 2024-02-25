#! /bin/bash

# gr_DEST="$HOME/Dropbox/ODPRTO/_TXT"
# cd $gr_DEST

echo "You are in ${gr_DEST}."
echo "Listing duplicate filenames before timestamp ... "

# Additional empty line ...
echo -e "\n"


echo "Result ..."
# Command ...
for F in $(ls -1 | sed 's/_........\.txt$//' | uniq -d); do ls -1 ${F}*; done


