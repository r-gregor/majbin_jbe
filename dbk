#! /bin/bash

### Name:	dbk.sh
### Author:	RgregoR
### Date:	2016-04-13
### Decription:
### Script that kills dropbox process and displays message if command was successful or not.
### 
### 
 

gr_DBPN=$(ps aux | grep dropbox | grep -v grep | head -n1 | awk '{print $2}')

if [ x${gr_DBPN} == x ]; then
	echo "There is no active Dropbox process ..."
	exit 1
fi

echo "Dropbox process num: ${gr_DBPN}"
echo 'Killing Dropbox ...'

sudo kill -9 ${gr_DBPN}
if [ $? -eq 0 ]; then
	echo "Dropbox successfully killed ..."
else
	echo "No such process. Check process list ..."
fi


