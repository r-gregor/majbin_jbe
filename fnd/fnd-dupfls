#! /bin/bash

### Name:	find-duplicatef-01.sh
### Author:	RgregoR
### Date:	20140420
### Decription: ONELINER that finds all duplicate files (by contents) in groups separated ba empty lines ...
### 
### 
### 

find -not -empty -type f -exec md5sum {} \; 2>/dev/null | sort -rn | uniq -w 32 --all-repeated=prepend | cut -d '*' -f2

