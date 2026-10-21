#! /usr/bin/env bash
# fname: fcopy-to-multiple-dirs.sh
# descpt: copy selected files to multiple directories. Add each file with option -f and each direcory with option -d
# 20260506 v1 -- copy selected files to multiple directories. Add each file with option -f
#                and each direcory with option -d
# 20260507 v2 -- added until loop to cycle trough multiple parameters for single -f and -d option
#                function usage() updated acordingly
#                IFS='' --> important: otherwise filenames and path strings do not get copied correctly
# 20260804 v3 -- renamed to fcopy-to-multiple-dirs.sh
# last: 20260804
# ---

# === GLOBALS ===
set -e

fjls=()
dsts=()
darg=false
farg=false
OIFS=$IFS

# === FUNCTIONS ===
usage() {
	printf "[!] usage: fcopy-to-multiple-dirs -f <fnm1> <fnm2> <"fnm3 with spaces"> -d <dirnm1> <dirnm2> ...\n"
	printf "                                  -h ... print this message\n\n"
}

# === MAIN ===
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
	printf "[e] no file selected\n"
	usage
	exit 1
fi


if [ "${darg}" != "true" ]; then
	printf "[e] no directory selected\n"
	usage
	exit 1
fi
IFS=$OIFS

for DDD in "${dsts[@]}"; do
	if [ ! -d "${DDD}" ]; then
		printf "[e] no such directory: ${DDD}\n\n"
		exit 1
	fi
done

for FFF in "${fjls[@]}"; do
	if [ ! -f "${FFF}" ]; then
		printf "[e] no such file: ${FFF}\n\n"
		exit 1
	fi
done

for DST in "${dsts[@]}"; do
	/usr/bin/cp -vi "${fjls[@]}" "${DST}"
done

printf "\n"

