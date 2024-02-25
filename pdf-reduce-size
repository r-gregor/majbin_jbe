#! /usr/bin/env bash

### pdf_reduce-size.sh
### 20171001
### reducing scanned pdf-file size:
### - making a copy
### - convert to ps
### - convert back to pdf (with new reduced size)
### - remove OLD files ...
###
### TO BE USED AS COMMAND PIPED TO FROM FILESLIST:
###		for F in *.pdf; do ~/majstaf/coding/pdf_reduce-size.sh $F; done
###
### OR AS A SINGLE FILE:
### ~/majstaf/coding/pdf_reduce-size.sh "Filename with spaces.pdf"
### _____________________________________________________________

if [ $# -ne 1 ]; then
	echo -e "\nThere should be one and only one argumanet: filename.pdf!"
	echo "Try again!"
	exit 1
fi

# asign the parameter (filename) to local variable
gr_FJL=$1

# create a backup copy of file if something goes wrong
echo -e "\nMaking a copy of file ${gr_FJL}."
cp -vn "${gr_FJL%.*}.pdf" "${gr_FJL%.*}_bekap.pdf"

# 1-st step: create ps file with pdf2ps
echo "Creating ${gr_FJL}.ps with pdf2ps."
pdf2ps "${gr_FJL%.*}.pdf" "${gr_FJL%.*}.ps"

# 2-cond step: create pdf from ps with ps2pdf
echo "Creating ${gr_FJL%.*}.pdf (reduced) with ps2pdf."
ps2pdf "${gr_FJL%.*}.ps" "${gr_FJL%.*}_rdc.pdf"

# 3-rd step: remove OLD files
echo "Removing OLD pdf, bekap and ps files ..."
rm -v "${gr_FJL%.*}.pdf" "${gr_FJL%.*}.ps" "${gr_FJL%.*}_bekap.pdf"
