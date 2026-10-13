#! /usr/bin/env bash
# fname: w3md-en.sh
# descpt: convert single 'html-file'  to 'txt-file' with w3m
# 20261006
# last: 20261006
# ---

# === GLOBALS ===
#  EN-proxy:
# prx_ip=172.17.3.64
prx_ip=10.91.8.21
export http_proxy=http://${prx_ip}:80/
export ftp_proxy=ftp://${prx_ip}:8021/
export https_proxy=http://${prx_ip}:80/

# === FUNCTIONS ===
fname_string_adjustment() {
	today=$(date +"%Y%m%d")
	fname_str="$1"
	fname_str_updated=$(echo "${fname_str}" | \
		sed "s/[:]\+//g" | \
		sed "s/[;]\+//g" | \
		sed "s/[\.]\+//g" | \
		sed "s/[,]\+//g" | \
		sed "s/[\?]\+//g" | \
		sed "s/[\@]\+//g" | \
		sed "s/  */-/g" | \
		sed "s/--*/-/g" | \
		tr '[[:upper:]]' '[[:lower:]]'
	)

	printf "${fname_str_updated}-${today}.txt"
}


usage() {
	printf "\n\t[u] usage: <scriptmname> [web-URL] \"[fname inside double quotes]\" [prefix: c, go, bash, ...(optional)]\n\n"
}

dump_command() {
	w3m -dump -cols 110 "$@"
}

# === MAIN ===
clear

if [ $# -lt 2 ]; then
	usage
	exit 1
fi

if [ $# -eq 2 ]; then
	weburl="$1"
	flnm=$(fname_string_adjustment "$2")
elif [ $# -eq 3 ]; then
	weburl="$1"
	pfnm=$(fname_string_adjustment "$2")
	flnm="${3}-${pfnm}"
else
	usage
	exit 1
fi


printf "[i] %-10s%s\n" "Web URL:" "${weburl}"
printf "[i] %-10s%s\n" "filename:" "${flnm}"

read -r -p "[?] confirm?"

printf "filename: ${flnm}\n" >> "${flnm}"
printf "${weburl}\n\n" >> "${flnm}"
dump_command "${weburl}" >> "${flnm}"
echo -e "\n\n---\n" >> "${flnm}"

printf "[i] done\n\n"

