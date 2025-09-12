#!/bin/bash

### scriopt that:
### 1 - converts documnet to linux lineendins format (dos2unix)
###	2 - rewraps paragraphs to [N] chrs width (fmt --width=N [filename])
### fmt - simple optimal text formatter (included in cygwin and Lubuntu)
### 3 - backup copy tp ~/.tmp --> rename to new rewraped --> remove backup (20181015)



unset gr_FAJL

clear

if [ $# -ne 2 ]; then
	echo
	echo "Usage: $0 [filename] [N]"
	echo "           filename ... file to rewrap"
	echo "           N .......... number of chars per line"
	echo
	exit 1
fi

gr_FAJL=${1}
CHRSPLINE=${2}

dos2unix ${gr_FAJL}

gr_FAJL_tmp=tmp_${gr_FAJL}

echo
echo  "fmt --width=${CHRSPLINE} -s ${gr_FAJL} >> ${gr_FAJL_tmp}"
fmt --width=${CHRSPLINE} -s ${gr_FAJL} >> ${gr_FAJL_tmp}

echo
cp ${gr_FAJL} ~/.tmp/
echo "${gr_FAJL} copied to ~/.tmp"

echo
rm ${gr_FAJL}
mv ${gr_FAJL_tmp} ${gr_FAJL}
echo "${gr_FAJL_tmp} renamed to: ${gr_FAJL}"

echo
echo "Removing temporary file:"
rm -i ~/.tmp/${gr_FAJL}
echo -e "\nDONE!\n"
