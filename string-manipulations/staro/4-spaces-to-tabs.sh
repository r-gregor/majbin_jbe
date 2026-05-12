#! /bin/bash
# filename: 4-spaces-to-tabs.sh
# run on multiple files:
# for FFF in $(find -type f -iname "*\.py"); do $RUNPATH/4-spaces-to-tabs.sh $FFF; done

f_name=$1

echo -n "Converting 4 spaces to tabs for file ${f_name} ... "
sed -i 's/ \{4\}/\t/g' ${f_name}
echo "[OK]."
