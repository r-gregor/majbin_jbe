#! /usr/bin/env bash

### updated 20220202:
###    added ${DEST1}, and ${DEST2}
###    changed for loop
### -------------------------------
### update 20250305: new SRCDIR
### -------------------------------


CMD1=~/.local/bin/rsort-by-enddate-g
CMD2=~/.local/bin/rsort-by-tmstmp-c
SRCDIR="/home/rgregor/majstaf/jbegit/knowledgedb"

DEST1="C_and_Cpp,JAVA,PYTHON,CS_and_other_PL,GIT,VIM,DOCKER,LINUX_SYSTEM,BASH,TXT,ZIG"
DEST2="C_and_Cpp JAVA PYTHON CS_and_other_PL GIT VIM DOCKER LINUX_SYSTEM BASH TXT ZIG"

usage() {
MSG=$(cat << HDOC

Usage: $0 [args]
	args:	-h ... help
		-n ... number of last files by date

		If no args, then last 10


HDOC
)
	echo "${MSG}"
}

noargs="true"

while getopts "hn:" arg; do
	case ${arg} in
		h)
			usage
		;;

		n)
			num=${OPTARG}
			for PTH in ${DEST2}; do
				echo "--- ${SRCDIR}/_${PTH} ---"
				cd ${SRCDIR}/_${PTH} && ${CMD2} | head -n ${num}; done
		;;

		*)
			echo "Displaying last 10 files from ${SRCDIR}/_{"${DEST1}"}"
			echo "For more options/usage run with -h!"
			echo ""
			for PTH in ${DEST2}; do
				echo "--- ${SRCDIR}/_${PTH} ---"
				cd ${SRCDIR}/_${PTH} && ${CMD2} | head -n10; done
		;;
	esac
	noargs="false"
done


if [[ ${noargs} == "true" ]]; then
	echo "Displaying last 10 files from ${SRCDIR}/_{"${DEST1}"}"
	echo "For more options/usage run with -h!"
	echo ""
	for PTH in ${DEST2}; do
		echo "--- ${SRCDIR}/_${PTH} ---"
		cd ${SRCDIR}/_${PTH} && ${CMD2} | head -n10; done
fi

