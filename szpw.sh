#! /bin/bash
gr_brs=~/.tmp
cat /dev/null > ${gr_brs}/szplotdwg.txt
ls -1 *.dwg >> ${gr_brs}/szplotdwg.txt && unix2dos ${gr_brs}/szplotdwg.txt && cygstart ${gr_brs}/szplotdwg.txt
