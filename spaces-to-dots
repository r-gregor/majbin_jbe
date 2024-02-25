#! /bin/bash
### script that replaces spaces with dots in filenames ...

echo ""
printf "%s\n" "***************************************************"
printf "%s\n" "* Replacing spaces in filenames with DOTS! *"
printf "%s\n" "***************************************************"

spc=/tmp/spaces.lst
printf "\n%s" "Filenames with spaces > $spc ..."
ls -1 | grep '[[:space:]]' > $spc
if [ $? -eq 0 ]; then printf "%s\n" " done"; fi

printf "\n%s\n" "Replacing spaces with UNDERSCORES ..."
while read f ; do mv -vvv "$f" $(echo ${f} | tr ' ' '.'); done < $spc
if [ $? -eq 0 ]; then printf "%s\n" "... done"; fi

printf "\n%s" "Removing $spc ..."
rm $spc
if [ $? -eq 0 ]; then printf "%s\n" " done"; fi
