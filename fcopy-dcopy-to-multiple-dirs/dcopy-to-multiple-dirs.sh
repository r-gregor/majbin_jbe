#! /usr/bin/env bash
# filename: dcopy-to-multiple-dirs.sh
# 20260506 v1 -- copy selected dirs to multiple directories. Add each source dir with option -s
#                and each dest direcory with option -d
# 20260507 v2 -- added until loop to cycle trough multiple parameters for single -s and -d option
#                function usage() updated acordingly
#                IFS='' --> important: otherwise filenames and path strings do not get copied correctly
# 20260804 v3 -- renamed to dcopy-to-multiple-dirs.sh from copy-files-to-multiple-dirs.sh
#                -f option renamed to -s (source dir), -d remains as dest dir
# last: 20260507
# ---

set -e

srcs=()
dsts=()
darg=false
sarg=false

usage() {
cat <<USAGE

usage: dcopy-to-multiple-dirs -s <sdir1> <sdir2> <"sdir3 with spaces"> -d <destdir1> <destdir2> ...
                                   -h ... print this message

USAGE
}

OIFS=$IFS
IFS='' # important: otherwise filenames and path strings do not get copied correctly
while getopts "s:d:h" opt; do
	case $opt in
		s)
			srcs+=("$OPTARG")
			until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
				srcs+=($(eval "echo \${$OPTIND}"))
				OPTIND=$((OPTIND + 1))
			done
			sarg=true
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

if [ "${sarg}" != "true" ]; then
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

for SDD in "${srcs[@]}"; do
	if [ ! -d "${SDD}" ]; then
		printf "[ERROR] no such file: ${SDD}\n\n"
		exit
	fi
done

for DST in "${dsts[@]}"; do
	/usr/bin/cp -vr "${srcs[@]}" "${DST}/"
done

