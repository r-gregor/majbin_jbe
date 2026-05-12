#! /usr/bin/env bash
# filename: dwnld-gtlb-sfnm
# download single filename from https://gitlab.com/r-gregor
# into: gitlab_r-regor/repo/<[dirname/]filename>
# 20260421 v1
# last: 20260421
# ---

HUB=gitlab

if [ $# -ne 2 ]; then
	printf "[ERROR] wrong number of parameters\n"
	printf "Usage: $0 <repository> <file name>\n"
	printf "\n"
	exit
else
	repo=$1
	src=$2
fi

dhub="${HUB}_r-gregor_$(date +'%Y%m%d')"
dst="${dhub}/${repo}"

if [ ! -d "${dst}" ]; then
	mkdir -pv "${dst}"
fi

if [[ ${src} =~ "/" ]]; then
	fdir="${src%/*}"
	fname=${src##*/}
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

printf "[INFO] download from %s ... into\n" "${ipath}"
printf "[INFO] ./${opath} ... "
read -p "OK?"

# wget "${ipath}" -O "${opath}"
curl -s -f -o "./${opath}" "${ipath}"

if [ $? -ne 0 ]; then
	printf "[ERROR] Could not download file: ${src}\n\n"
	exit
else
	printf "[INFO] download successful\n\n"
fi

