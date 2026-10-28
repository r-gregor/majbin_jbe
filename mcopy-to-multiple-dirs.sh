#! /usr/bin/env bash
# fname: mcopy-to-multiple-dirs.sh
# descpt: copy multiple selected files/dirs to multiple directories. Add source dirs with option -s and dest direcories with option -d
# 20261028 v1
# last: 20261028
# ---

# === GLOBALS ===
set -e

unset selections
unset dsts
declare -a selections
declare -a dsts

darg=false
sarg=false


# === FUNCTIONS ===
usage() {
	printf "[!] usage: mcopy-to-multiple-dirs -s <fname1> <sdir2> <\"sdir3 with spaces\"> -d <destdir1> <destdir2> ...\n"
	printf "                                  -h ... print this message\n\n"
}

# === MAIN ===
OIFS=$IFS
IFS='' # important: otherwise filenames and path strings do not get copied correctly

unset dest_dirs
declare -a dest_dirs

while getopts "s:d:h" opt; do
	case $opt in
		s)
			selections+=("$OPTARG")
			until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
				selections+=($(eval "echo \${$OPTIND}"))
				OPTIND=$((OPTIND + 1))
			done
			sarg=true
			;;
		d)
			dest_dirs+=("$OPTARG")
			until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
				dest_dirs+=($(eval "echo \${$OPTIND}"))
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
	printf "[e] no file/directory selected\n"
	usage
	exit 1
fi

if [ "${darg}" != "true" ]; then
	printf "[e] no destination directory selected\n"
	usage
	exit 1
fi

IFS=$OIFS

for selection1 in "${selections[@]}"; do
	if [ ! -d "${selection1}" ] && [ ! -f "${selection1}" ]; then
		printf "[e] no such file/directory: '%s'\n\n" "${selection1}"
		exit 1
	fi
done

printf "copy files/directories:\n"
for selection2 in "${selections[@]}"; do
	printf "\t'%s'\n" "${selection2}"
done

printf "into:\n"
for qdst in "${dest_dirs[@]}"; do
	printf "\t'%s/'\n" "${qdst%/}"
done
read -r -p "[?] ok?"

for DST in "${dest_dirs[@]}"; do
	UPDTDIR="${DST// /}"
	if [ ! -d "${UPDTDIR}" ]; then
		printf "[e] no such directory: ${UPDTDIR}\n\n"
		exit 1
	fi

	for selection3 in "${selections[@]}"; do
		if [ -d "${selection3}" ]; then
			if [ -d "${UPDTDIR}/${selection3}" ]; then
				read -r -p "[?] overwrite existing directory: ${DST%/}/${selection3} (y/Y)? " ans
				if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
					/usr/bin/cp -vr "${selection3}" "${UPDTDIR}"/
				else
					continue
				fi
			else
				read -r -p "[?] copy directory ${selection3} into: ${DST%/}/ (y/Y)? " ans
				if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
					/usr/bin/cp -vr "${selection3}" "${UPDTDIR}"/
				else
					continue
				fi
			fi
		else
			/usr/bin/cp -vi "${selection3}" "${UPDTDIR}"/
		fi
	done
done

printf "\n"

