#! /usr/bin/env bash
# fname: lynxd.sh
# descpt: convert http-tech-site into txt-file using lynx
# 20250925 v1 remove option to use dumplist
# 20260731 v2 implement fname_string_adjustment() function
#             add prefix option
# 20260804 v3 move 'lynx dump' command into dump_command() function
# 20261013 v4 make universal --> proxy settins only if on cygwin
# last: 20261013
# ---

# === FUNCTIONS ===
check_for_ostype() {
	case "$OSTYPE" in
		cygwin*)
			# EN-proxy ...
			# prx_ip=172.17.3.64
			prx_ip=10.91.8.21
			export http_proxy=http://${prx_ip}:80/
			export ftp_proxy=ftp://${prx_ip}:8021/
			export https_proxy=http://${prx_ip}:80/
		;;

		msys*)
			# EN-proxy ...
			# prx_ip=172.17.3.64
			prx_ip=10.91.8.21
			export http_proxy=http://${prx_ip}:80/
			export ftp_proxy=ftp://${prx_ip}:8021/
			export https_proxy=http://${prx_ip}:80/
		;;
		
		*)
		;;
	esac
}

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
	printf "[U] usage: <scriptmname> [web-URL] \"[fname inside double quotes]\" [prefix: c, go, bash, ...(optional)]\n\n"
}

dump_command() {
	lynx -dump -width=110 "$@"
}

# === MAIN ===
clear

check_for_ostype

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

read -r -p "[?] continue?"

printf "filename: ${flnm}\n" >> "${flnm}"
printf "${weburl}\n\n" >> "${flnm}"
dump_command "${weburl}" >> "${flnm}"
printf -- "\n\n---\n" >> "${flnm}"

printf "[i] done\n\n"

