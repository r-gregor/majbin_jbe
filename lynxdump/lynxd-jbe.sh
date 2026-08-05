#! /usr/bin/env bash
# fname: lynxd-jbe.sh
# 20250925 v1 remove option to use dumplist
# 20260731 v2 implement fname_string_adjustment() function
#             add prefix option
# 20260804 v3 move 'lynx dump' command into dump_command() function
# last: 20260804
# ---

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
	printf "\n\tUSAGE: <scriptmname> [web-URL] \"[fname inside double quotes]\" [prefix: c, go, bash, ...(optional)]\n\n"
}

dump_command() {
	lynx -dump -width=110 "$@"
}

# MAIN
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


printf "[INFO] %-10s%s\n" "Web URL:" "${weburl}"
printf "[INFO] %-10s%s\n" "filename:" "${flnm}"

printf "[INFO] Press <enter> to proceed or <ctrl-c> to quit"
read ANS

# echo "filename: ${flnm}" >> ${flnm}
# echo -e "${weburl}\n\n" >> ${flnm}
printf "filename: ${flnm}\n" >> ${flnm}
printf "${weburl}\n\n" >> ${flnm}
# lynx -dump -width=110 ${weburl} >> ${flnm}
dump_command ${weburl} >> ${flnm}
echo -e "\n\n---\n" >> ${flnm}

printf "[INFO] done\n"

