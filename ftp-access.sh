#! /bin/bash

### Name:	ftp_access.sh
### Author:	RgregoR
### Date:	2015-01-15
### Decription:	Script that connects to FTP site for up or down -loading files
### 
### 
### 

# Display menu:

clear

cat <<EOF
FTP acces to [lftp]:

1 - users.volja.net/gregorr
2 - r-gregor.slohosting.com
3 - rgregor.byethost22.com
0 - EXIT
-----------------------------------
EOF

echo -n "Enter 1, 2, 3 for acces, or 0 to exit  "
read GR_ANSWER

case "${GR_ANSWER}" in

	"1" )
	echo 
	lftp 'gregorr:zala00'@ftp.volja.net
	;;

	"2" )
	echo
	lftp 'r-gregor.slohosting.com:z7m17s11'@free.slohosting.com
	;;

	"3" )
	echo
	lftp 'b22_15819044:z7m17s11'@ftp.byethost22.com
	;;

	"0" )
	echo -e 'Bye!\n'
	exit
	;;

	* )
	echo
	echo -e "Enter 1, 2, 3 or 0.\n"
	exit 1
	;;

esac

