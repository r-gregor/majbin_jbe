### oneliner to read a list of webpages links from a file and inserts them to single text file:

### EN-proxy ...
### export http_proxy=http://172.17.3.64:80/


# Initialising global variables ...
gr_seznam="$HOME/majfajls/coding/w3mdump/_multi_dump_list.dat"
gr_dest="$PWD"

gr_d_filename="default-filename"

### FILENAME - MUST CREATE!! ###

# date in num-frmt: yyyymmdd ...
gr_dejt=$(date +%Y%m%d)


echo "Enter filename [no spaces, only hypens or underscores] :"
read gr_ANS

# filename to add html-dumps to ...
if [ -z ${gr_ANS} ]; then 
	
	gr_filename=${gr_d_filename}-multyf_${gr_dejt}.txt
else
	gr_imef=$(echo "${gr_ANS}" | tr ' ' '-') 
	gr_filename=${gr_imef}-multif_${gr_dejt}.txt
fi

# destination ...
gr_goto="${gr_dest}/${gr_filename}" 
echo "Destination: ${gr_goto}"

# If OK pres any key, else ctrl-c ...
read -p "Continue ?"
touch ${gr_goto}

echo "filename: ${gr_goto}" >> ${gr_goto}

for FFF in $(cat ${gr_seznam}); do echo "inserting $FFF into ${gr_goto}"; done
for FFF in $(cat ${gr_seznam}); do echo -e "$FFF\n" >> ${gr_goto}; w3m -dump -cols 110 $FFF >> ${gr_goto}; echo -e "\n\n\n---" >> ${gr_goto}; done




echo
echo 'DONE!'
echo

