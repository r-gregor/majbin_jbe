#! /usr/bin/env bash

# filename: lynx-multi-dump-fromlist-jbe
# 20250925 v1 en: remove option to use dumplist
# 20251028 v2  d: convert from en to jbe
# last: 20251028
# ---

if [ $# -eq 1 ]; then
	gr_seznam=$1
	gr_name="default-fname"
	if [ ! -f $gr_seznam ]; then
		echo -e "[ERROR] no such file: ${gr_seznam}\n"
		exit
	fi
elif [ $# -eq 2 ]; then
	gr_seznam=$1
	if [ ! -f $gr_seznam ]; then
		echo -e "[ERROR] no such file: ${gr_seznam}\n"
		exit
	fi
	gr_name=$2
else
	echo -e " Usage:"
	echo -e "      \t$(basename $0) <list> <name>"
	echo -e "    or:"
	echo -e "      \t$(basename $0) <list> [default-fname]"
	echo -e ""
	exit
fi

gr_dest="$PWD"
gr_dejt=$(date +%Y%m%d)
gr_filename=${gr_name}-multif-${gr_dejt}.txt

# destination ...
gr_goto="${PWD}"
echo "Destination: ${gr_goto}/${gr_filename}"

# If OK pres any key, else ctrl-c ...
read -p "Continue ?"
cd $gr_goto
touch ${gr_filename}

echo "filename: ${gr_filename}" >> ${gr_filename}

for FFF in $(cat ${gr_seznam}); do echo "inserting $FFF into ${gr_filename}"; done
for FFF in $(cat ${gr_seznam}); do echo -e "$FFF\n" >> ${gr_filename}; lynx -dump -width=110 $FFF >> ${gr_filename}; echo -e "\n\n\n---" >> ${gr_filename}; done

echo
echo -e "DONE!\n"

