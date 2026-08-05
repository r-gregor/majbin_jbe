#! /usr/bin/env bash
# fname: w3m-multi-dump-fromlist-jbe.sh
# 20260106 v1
# 20260731 v2 implement fname_string_adjustment() function
#             add prefix option
# 20260804 v3 move 'w3m dump' command into dump_command() function
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
	w3m -dump -cols 110 "$@"
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
		printf "[ERROR] no such file: ${seznam}\n\n"
		exit 1
	fi
	ffname=$(fname_string_adjustment "$2")
elif [ $# -eq 3 ]; then
	seznam="$1"
	if [ ! -f $seznam ]; then
		printf "[ERROR] no such file: ${seznam}\n\n"
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
printf "[INFO] Destination: ${fdest}/${ffname}\n"

# If OK pres any key, else ctrl-c ...
read -p "[INFO] Continue ?"
cd $fdest
touch ${ffname}

printf "filename: ${ffname}\n" >> ${ffname}

for FFF in $(cat ${seznam}); do
	printf "[INFO] inserting $FFF into ${ffname}\n"
	printf "$FFF\n" >> ${ffname}
	# lynx -dump -width=110 $FFF >> ${ffname}
	dump_command $FFF >> ${ffname}
	printf "\n\n\n---\n" >> ${ffname}
done

printf "[INFO] done\n"

