#! /usr/bin/env bash
# fname: w3m-multi-dump-fromlist-en.sh
# descpt: convert multiple 'html-files' into single 'txt-file' with w3m
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

	printf "${fname_str_updated}-multif-${today}.txt"
}

usage() {
	printf "\n\t[u] usage: <scriptmname> [list] \"[fname inside double quotes]\" [prefix: c, go, bash, ...(optional)]\n\n"
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
	seznam="$1"
	if [ ! -f "${seznam}" ]; then
		printf "[E] no such file: ${seznam}\n\n"
		exit 1
	fi
	ffname="$(fname_string_adjustment "$2")"
elif [ $# -eq 3 ]; then
	seznam="$1"
	if [ ! -f "${seznam}" ]; then
		printf "[E] no such file: ${seznam}\n\n"
		exit 1
	fi
	pfnm="$(fname_string_adjustment "$2")"
	ffname="${3,,}-${pfnm}"
else
	usage
	exit 1
fi

dest="$PWD"
fdest="${PWD}"
printf "[INFO] Destination: ${fdest}/${ffname}\n"

read -r -p "[i] continue ?"
cd "${fdest}"
touch "${ffname}"

printf "filename: ${ffname}\n" >> "${ffname}"

for FFF in "$(cat "${seznam}")"; do
	printf "[i] inserting '%s' into '%s'\n" "${FFF}" "${ffname}"
	printf "${FFF}\n" >> "${ffname}"
	dump_command "${FFF}" >> "${ffname}"
	printf "\n\n\n---\n" >> "${ffname}"
done

printf "[i] done\n\n"

