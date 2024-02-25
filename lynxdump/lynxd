### script that cretaes a TXT file, inserts a webpage URL to the top row
### and creates lynx -dump of a web page after ...

###  EN-proxy ...
# export http_proxy=http://172.17.3.64:80/

clear
gr_dejt=$(date +%Y%m%d)

if [ $# -ne 2 ]; then
	echo 'USAGE: <scriptmname> [web-URL] [filename]' 	
	echo
	exit
fi

gr_weburl="$1"
gr_fjl="$2"
gr_flnm="${gr_fjl}_${gr_dejt}.txt"

# echo "Web URL: ${gr_weburl}"
# echo "filename: ${gr_flnm}"

printf "%-20s%s\n" "Web URL:" "${gr_weburl}"
printf "%-20s%s\n\n" "filename:" "${gr_flnm}"


read -p "Press <enter> to proceed or <ctrl-c> to quit"

echo "filename: ${gr_flnm}" >> ${gr_flnm}
echo -e "${gr_weburl}\n\n" >> ${gr_flnm}
lynx -dump -width=110 ${gr_weburl} >> ${gr_flnm}
echo -e "\n\n---\n" >> ${gr_flnm}

echo
echo 'DONE!'
echo

