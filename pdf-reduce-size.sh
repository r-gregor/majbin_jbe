#! /usr/bin/env bash
# fname: pdf-reduce-size.sh
# descpt: reduce size of scaned into pdf files
# 20261001 v1
# 20261021
# last: 20261021

# === GLOBALS ===
unset FJL

# === MAIN ===
if [ $# -ne 1 ]; then
	printf "[e] there should be one and only one argumanet: <pdf-filename>\n\n"
	exit 1
else
	FJL="$1"
fi

# create a backup copy of file if something goes wrong
printf "[i] making a copy of file ${FJL} ...\n"
cp -vn "${FJL%.*}.pdf" "${FJL%.*}_bekap.pdf"

# 1-st step: create ps file with pdf2ps
printf "[i] creating ${FJL}.ps with pdf2ps ...\n"
pdf2ps "${FJL%.*}.pdf" "${FJL%.*}.ps"

# 2-cond step: create pdf from ps with ps2pdf
printf "[i] creating ${FJL%.*}.pdf (reduced) with ps2pdf ...\n"
ps2pdf "${FJL%.*}.ps" "${FJL%.*}_rdc.pdf"

# 3-rd step: remove OLD files
printf "[i] removing OLD pdf, bekap and ps files ...\n"
rm -v "${FJL%.*}.pdf" "${FJL%.*}.ps" "${FJL%.*}_bekap.pdf"

printf "\n"

