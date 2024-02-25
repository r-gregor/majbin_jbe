#! /bin/bash
### script that replaces spaces with hypens in filenames ...

echo ""
printf "%s\n" "***************************************************"
printf "%s\n" "* Replacing UNDERSCORES in filenames with HYPENS! *"
printf "%s\n" "***************************************************"

spc=/tmp/underscores.lst
printf "\n%s" "Filenames with UNDERSCORES > $spc ..."
ls -1 | grep '_' > $spc
if [ $? -eq 0 ]; then printf "%s\n" " done"; fi

printf "\n%s\n" "Replacing UNDERSCORES with HYPENS ..."
while read f ; do mv -vvv "$f" $(echo ${f} | tr '_' '-'); done < $spc
if [ $? -eq 0 ]; then printf "%s\n" "... done"; fi

printf "\n%s" "Removing $spc ..."
rm $spc
if [ $? -eq 0 ]; then printf "%s\n" " done"; fi
