#! /bin/bash
gr_brs=~/.tmp
cat /dev/null > ${gr_brs}/szplotpdf.txt
ls -1 *.pdf >> ${gr_brs}/szplotpdf.txt && unix2dos ${gr_brs}/szplotpdf.txt && cygstart ${gr_brs}/szplotpdf.txt
