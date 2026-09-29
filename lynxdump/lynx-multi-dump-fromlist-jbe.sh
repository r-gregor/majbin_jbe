#! /usr/bin/env bash
# filename: lynx-multi-dump-fromlist-jbe.sh
# v1_20250925 remove option to use dumplist
# v2 20260731 implement fname_string_adjustment() function
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
	printf "\n\tUSAGE: <scriptmname> [list] \"[fname inside double quotes]\" [prefix: c, go, bash, ...(optional)]\n\n"
}

dump_command() {
	lynx -dump -width=110 "$@"
}

#MAIN
clear

if [ $# -lt 2 ]; then
	usage
	exit 1
fi

if [ $# -eq 2 ]; then
	seznam="$1"
	if [ ! -f $seznam ]; then
		printf "[E] no such file: ${seznam}\n\n"
		exit 1
	fi
	ffname=$(fname_string_adjustment "$2")
elif [ $# -eq 3 ]; then
	seznam="$1"
	if [ ! -f $seznam ]; then
		printf "[E] no such file: ${seznam}\n\n"
		exit 1
	fi
	pfnm=$(fname_string_adjustment "$2")
	ffname="${3,,}-${pfnm}"
else
	usage
	exit 1
fi

dest="$PWD"

# destination ...
fdest="${PWD}"
printf "[i] Destination: ${fdest}/${ffname}\n"

# If OK pres any key, else ctrl-c ...
read -r -p "[?] [i] Continue ?"
cd $fdest
touch ${ffname}

printf "filename: ${ffname}\n" >> ${ffname}

for FFF in $(cat ${seznam}); do
	printf "[i] inserting $FFF into ${ffname}\n"
	printf "$FFF\n" >> ${ffname}
	# lynx -dump -width=110 $FFF >> ${ffname}
	dump_command $FFF >> ${ffname}
	printf "\n\n\n---\n" >> ${ffname}
done

printf "[i] done\n"

