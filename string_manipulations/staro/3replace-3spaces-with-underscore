#! /bin/bash
### script that replaces 3-ple spaces with hypens in filenames ...

echo ""
printf "%s\n" "****************************************************"
printf "%s\n" "* Replacing 3-ple spaces in filenames with hypens! *"
printf "%s\n" "****************************************************"

spc=/tmp/3spaces.lst
printf "\n%s" "Filenames with 3-ple hypens > $spc ..."
ls -1 | grep '\---' > $spc
if [ $? -eq 0 ]; then printf "%s\n" " done"; fi

printf "\n%s\n" "Replacing spaces with hypens ..."
while read F ; do mv -vvv "$F" $(echo $F | sed 's/---/_/g'); done < $spc
if [ $? -eq 0 ]; then printf "%s\n" "... done"; fi

printf "\n%s" "Removing $spc ..."
rm $spc
if [ $? -eq 0 ]; then printf "%s\n" " done"; fi

