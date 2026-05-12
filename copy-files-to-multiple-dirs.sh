#! /usr/bin/env bash
# filename: copy-files-to-multiple-dirs
# 20260506 v1 -- copy selected files to multiple directories. Add each file with optinon -f
#                and each direcory with option -d
# 20260507 v2 -- added until loop to cycle trough multiple parameters for single -f and -d option
#                function usage() updated acordingly
#                IFS='' --> important: otherwise filenames and path strings do not get copied correctly
# last: 20260507
# ---

set -e

fjls=()
dsts=()
darg=false
farg=false

usage() {
cat <<USAGE

usage: copy-files-to-multiple-dirs -f <fnm1> <fnm2> <"fnm3 with spaces"> -d <dirnm1> -d <dirnm2> ...
                                   -h ... print this message

USAGE
}

OIFS=$IFS
IFS='' # important: otherwise filenames and path strings do not get copied correctly
while getopts "f:d:h" opt; do
	case $opt in
		f)
			fjls+=("$OPTARG")
			until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
				fjls+=($(eval "echo \${$OPTIND}"))
				OPTIND=$((OPTIND + 1))
			done
			farg=true
			;;
		d)
			dsts+=("$OPTARG")
			until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
				dsts+=($(eval "echo \${$OPTIND}"))
				OPTIND=$((OPTIND + 1))
			done
			darg=true
			;;
		h)
			usage
			exit
			;;
		*)
			usage
			exit
			;;
	esac
done

if [ "${farg}" != "true" ]; then
	echo "[ERROR] no file selected"
	usage
	exit
fi


if [ "${darg}" != "true" ]; then
	echo "[ERROR] no directory selected"
	usage
	exit
fi
IFS=$OIFS

for DDD in "${dsts[@]}"; do
	if [ ! -d "${DDD}" ]; then
		printf "[ERROR] no such directory: ${DDD}\n\n"
		exit
	fi
done

for FFF in "${fjls[@]}"; do
	if [ ! -f "${FFF}" ]; then
		printf "[ERROR] no such file: ${FFF}\n\n"
		exit
	fi
done

for DST in "${dsts[@]}"; do
	/usr/bin/cp -vi "${fjls[@]}" "${DST}"
done

