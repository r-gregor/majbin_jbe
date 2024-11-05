#! /bin/bash
### script that replaces spaces with hypens in filenames ...

echo ""
printf "%s\n" "***************************************************"
printf "%s\n" "* Replacing HYPENS in filenames with UNDERSCORES! *"
printf "%s\n" "***************************************************"

spc=/tmp/spaces.lst
printf "\n%s" "Filenames with HYPENS > $spc ..."
ls -1 | grep '-' > $spc
if [ $? -eq 0 ]; then printf "%s\n" " done"; fi

printf "\n%s\n" "Replacing HYPENS with UNDERSCORES ..."
while read f ; do mv -vvv "$f" $(echo ${f} | tr '-' '_'); done < $spc
if [ $? -eq 0 ]; then printf "%s\n" "... done"; fi

printf "\n%s" "Removing $spc ..."
rm $spc
if [ $? -eq 0 ]; then printf "%s\n" " done"; fi

