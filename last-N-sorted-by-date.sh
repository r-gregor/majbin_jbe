#! /usr/bin/env bash
# fname: last-N-sorted-by-date.sh
# descpt: display last n-files by in knowledgedb by category sorrted by date
# 20261009 v1
# last: 20261009
# ---

# === GLOBALS ===
# CMD1="${HOME}"/.local/bin/rsort-by-enddate-g
# CMD2="${HOME}"/.local/bin/rsort-by-tmstmp-c
SRCDIR="${HOME}/majstaf/${HST}git/knowledgedb"


DEST1="C_and_Cpp,JAVA,PYTHON,CS_and_other_PL,GIT,VIM,DOCKER,LINUX_SYSTEM,BASH,TXT,ZIG"
DEST2="C_and_Cpp JAVA PYTHON CS_and_other_PL GIT VIM DOCKER LINUX_SYSTEM BASH TXT ZIG"


# === FUNCTIONS ===
CMD1() {
	~/.local/bin/rsort-by-enddate-g
}

CMD2() {
	~/.local/bin/rsort-by-tmstmp-c
} 
usage() {
MSG=$(cat << HDOC

[U] usage: last-N-sorted-by-date-d-backup [args]
	args:	-h ... help
			-n ... number of last files by date

		If no args, then last 10


HDOC
)
	echo "${MSG}"
}

# === MAIN ===
noargs="true"

while getopts "hn:" arg; do
	case "${arg}" in
		h)
			usage
		;;

		n)
			num="${OPTARG}"
			for PTH in ${DEST2}; do
				printf -- "--- ${SRCDIR}/_${PTH} ---\n"
				cd "${SRCDIR}/_${PTH}" && CMD2 | head -n "${num}"
			done
		;;

		*)
			printf "[i] displaying last 10 files from ${SRCDIR}/_${DEST1}\n"
			printf "[i] for more options/usage run with -h\n\n"

			for PTH in ${DEST2}; do
				printf -- "--- ${SRCDIR}/_${PTH} ---\n"
				cd "${SRCDIR}/_${PTH}" && CMD2 | head -n10
			done
		;;
	esac
	noargs="false"
done


if [[ ${noargs} == "true" ]]; then
	printf "[i] displaying last 10 files from ${SRCDIR}/_${DEST1}\n"
	printf "[i] for more options/usage run with -h\n\n"

	for PTH in ${DEST2}; do
		printf -- "--- ${SRCDIR}/_${PTH} ---\n"
		cd "${SRCDIR}/_${PTH}" && CMD2 | head -n10; done
fi

printf "\n"

