#! /usr/bin/env bash
# fname: mcopy-to-prenos.sh
# descpt: copy multiple selected files/dirs to prenos git-repo
# 20261028 v1
# last: 20261028
# ---

# === GLOBALS ===
set -e
PRNS_DEST="${HOME}/majstaf/${HST}git/prenos"

unset selections
unset prns_dest
declare -a selections
declare -a prns_dest

earg=false
jarg=false
marg=false
aarg=false
sarg=false
OIFS=$IFS

# === FUNCTIONS ===
usage() {
	printf "[!] usage: mcopy-to-prenos -[e,j,m,a,h] -s <filename1> <filename2> <dirname1>...
        -e    add file to update_en  and/or
        -j    add file to update_jbe and/or
        -m    add file to update_mdb or
        -a    add file to update_jbe and update_mdb and update_en

        -s    <filenames>, <dirnames>, ... mandatory!

        -h    print this message

"
}

# === MAIN ===
IFS='' # important: otherwise filenames and path strings do not get copied correctly


while getopts "ejmahs:" opt; do
	case $opt in
		e)
			earg=true
			prns_dest+=("en")
			;;
		j)
			jarg=true
			prns_dest+=("jbe")
			;;
		m)
			marg=true
			prns_dest+=("mdb")
			;;
		a)
			aarg=true
			prns_dest=()
			prns_dest=("en" "jbe" "mdb")
			;;
		s)
			selections+=("$OPTARG")
			until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
				selections+=($(eval "echo \${$OPTIND}"))
				OPTIND=$((OPTIND + 1))
			done
			sarg=true
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

if [ "${#prns_dest[@]}" -lt 1 ]; then
	printf "[e] no destinantion directory selected\n"
	usage
	exit 1
fi

IFS=$OIFS

printf "copy files/directories:\n"
for selection1 in "${selections[@]}"; do
	printf "\t${selection1}\n"
done

printf "into:\n"
for qdst in "${prns_dest[@]}"; do
	printf "\tupdate_${qdst}\n"
done
read -r -p "[?] ok?"

for DST in "${prns_dest[@]}"; do
	UPDTDIR="${PRNS_DEST}/update_${DST// /}"
	if [ ! -d "${UPDTDIR}" ]; then
		printf "[e] no such directory: ${UPDTDIR}\n\n"
		exit 1
	fi

	for selection2 in "${selections[@]}"; do
		if [ -d "${selection2}" ]; then
			if [ -d "${UPDTDIR}/${selection2}" ]; then
				read -r -p "[?] overwrite existing directory: update_${DST}/${selection2} (y/Y)? " ans
				if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
					/usr/bin/cp -vr "${selection2}" "${UPDTDIR}"/
				else
					continue
				fi
			else
				read -r -p "[?] copy directory ${selection2} into: update_${DST}/ (y/Y)? " ans
				if [ "${ans}" == "y" ] || [ "${ans}" == "Y" ]; then
					/usr/bin/cp -vr "${selection2}" "${UPDTDIR}"/
				else
					continue
				fi
			fi
		else
			/usr/bin/cp -vi "${selection2}" "${UPDTDIR}"/
		fi
	done
done

printf "\n"

