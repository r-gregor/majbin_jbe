#! /usr/bin/env bash
# fname: last-N-sorted-by-date-d
# 20220202: added ${DEST1}, and ${DEST2}
#           changed for loop
# 20260407: DEST1, DEST2 ==> readarray 'ls -1' command into CATEGORIES
#           DRPBO --> KNWLGDB
# last: 20260407
#---

CMD1=${HOME}/.local/bin/rsort-by-enddate-g
CMD2=${HOME}/.local/bin/rsort-by-tmstmp-c
KNWLGDB="/home/rgregor/majstaf/jbegit/knowledgedb"

# 20260407
unset CATEGORIES
readarray -t CATEGORIES < <(ls -1 "${KNWLGDB}")

### # TEST
### for CAT in "${CATEGORIES[@]}"; do printf "category: ${CAT}\n"; done
### read -p "OK?"

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

