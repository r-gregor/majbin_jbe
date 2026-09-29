#! /usr/bin/env bash
# filename: gt-dwnld-gtlb-sfnm.sh
# descpt: Download single filename from https://gitlab.com/r-gregor into: gitlab_r-regor/repo/<[dirname/]filename>
# 20260421 v1
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

HUB=gitlab

if [ $# -ne 2 ]; then
	printf "[E] wrong number of parameters\n"
	printf "Usage: $0 <repository> <file name>\n"
	printf "\n"
	exit
else
	repo="$1"
	src="$2"
fi

dhub="${HUB}_r-gregor_$(date +'%Y%m%d')"
dst="${dhub}/${repo}"

if [ ! -d "${dst}" ]; then
	mkdir -pv "${dst}"
fi

if [[ ${src} =~ "/" ]]; then
	fdir="${src%/*}"
	fname="${src##*/}"
	odir="${dst}/${fdir}"
else
	fname="${src}"
	odir="${dst}"
fi

oname="${fname}"
ipath="https://gitlab.com/r-gregor/${repo}/-/raw/main/${src}?ref_type=heads"
opath="${odir}/${oname}"

if [ ! -d "${odir}" ]; then
	mkdir -pv "${odir}"
fi

printf "[i] download from %s ... into\n" "${ipath}"
printf "[i] ./${opath} ... "
read -r -p "[?] OK?"

# wget "${ipath}" -O "${opath}"
curl -s -f -o "./${opath}" "${ipath}"

if [ $? -ne 0 ]; then
	printf "[E] Could not download file: ${src}\n\n"
	exit
else
	printf "[i] download successful\n\n"
fi

