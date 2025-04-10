#! /usr/bin/env bash

dumplist="$HOME/majstaf/majbin/w3mdump/multi-dump-list.dat"

if [ $# -eq 1 ]; then
	gr_seznam=$1
	if [ ! -f $gr_seznam ]; then
		gr_seznam=${dumplist}
		echo "No such file. Destination: ${dumplist}"
	fi
else
	gr_seznam=${dumplist}
fi

gr_dest="$PWD"
gr_d_filename="default-filename"
gr_dejt=$(date +%Y%m%d)

echo "Enter filename [no spaces, only hypens] :"
read gr_ANS

if [ -z ${gr_ANS} ]; then
	gr_filename=${gr_d_filename}-multyf-${gr_dejt}.txt
else
	gr_imef=$(echo "${gr_ANS}" | tr ' ' '-') 
	gr_filename=${gr_imef}-multif-${gr_dejt}.txt
fi

# destination ...
gr_goto="${PWD}"
echo "Destination: ${gr_goto}/${gr_filename}"

# If OK pres any key, else ctrl-c ...
read -p "Continue ?"
cd $gr_goto
touch ${gr_filename}

echo "filename: ${gr_filename}" >> ${gr_filename}

for FFF in $(cat ${gr_seznam}); do echo "inserting $FFF into ${gr_filename}"; done
for FFF in $(cat ${gr_seznam}); do echo -e "$FFF\n" >> ${gr_filename}; w3m -dump -cols 110 $FFF >> ${gr_filename}; echo -e "\n\n\n---" >> ${gr_filename}; done

echo
echo 'DONE!'
echo

