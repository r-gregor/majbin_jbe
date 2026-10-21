#! /usr/bin/env bash

# fname: ./last-N-sorted-by-date-d
# 20240516: changed source dirs
# 20260408: DEST1, DEST2 ==> readarray 'ls -1' command into CATEGORIES
#           DRPBO_d --> KNWLGDB
# last: 20260408
# ---

CMD1=~/.local/bin/rsort-by-enddate-g
CMD2=~/.local/bin/rsort-by-tmstmp-c
KNWLGDB=/home/rgregor/majstaf/mdbgit/knowledgedb

# 20260408
unset CATEGORIES
readarray -t CATEGORIES < <(ls -1 "${KNWLGDB}")

### # TEST
### for CAT in "${CATEGORIES[@]}"; do printf "category: ${CAT}\n"; done
### read -r -p "[?] OK?"

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
			for PTH in "${CATEGORIES[@]}"; do
				echo "--- ${KNWLGDB}/${PTH} ---"
				cd ${KNWLGDB}/${PTH} && ${CMD2} | head -n ${num}; done
		;;

		*)
			echo "Displaying last 10 files from all categories in: ${KNWLGDB}"
			echo "For more options/usage run with -h!"
			echo ""
			for PTH in "${CATEGORIES[@]}"; do
				echo "--- ${KNWLGDB}/${PTH} ---"
				cd ${KNWLGDB}/${PTH} && ${CMD2} | head -n10; done
		;;
	esac
	noargs="false"
done


if [[ ${noargs} == "true" ]]; then
	echo "Displaying last 10 files from all categories in: ${KNWLGDB}"
	echo "For more options/usage run with -h!"
	echo ""
	for PTH in "${CATEGORIES[@]}"; do
		echo "--- ${KNWLGDB}/${PTH} ---"
		cd ${KNWLGDB}/${PTH} && ${CMD2} | head -n10; done
fi

