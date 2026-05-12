#! /bin/bash

### Name:   Scriptname ...
### Author: Author ... 
### Date:   2013-05-24 
### Decription:
### 
### 
### 


if [ $# -eq 0 ]; then
    echo -e "Usage $0 + [filename]\n"
    exit 1
fi

gr_FJL=$1

gr_PGNM=$(echo "$(cat ${gr_FJL} | wc -l) / 80" | bc)
echo
echo -n "Number of pages of file ${gr_FJL} is:  __${gr_PGNM}__" 
echo

