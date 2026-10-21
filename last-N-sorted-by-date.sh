#! /usr/bin/env bash
# fname: last-N-sorted-by-date.sh
# descpt: List last 10 files from $KNOWLEDGEDB in all cathegories sorted by date
# 20220202: added ${DEST1}, and ${DEST2}
#           changed for loop
# 20260407: DEST1, DEST2 ==> readarray 'ls -1' command into CATEGORIES
#           DRPBO --> KNWLGDB
# last: 20260407
#---

KNWLGDB="${HOME}/majstaf/${HST}git/knowledgedb"

CMD1() {
	"${HOME}"/.local/bin/sort-files-by-end-date
}

CMD2() {
	"${HOME}"/.local/bin/rsort-by-tmstmp-c
}

unset CATEGORIES
readarray -t CATEGORIES < <(ls -1 "${KNWLGDB}")

usage() {
MSG=$(cat << HDOC

Usage: last-N-last [args]
    args:
        -h        ... help
        -n <num>  ... number of last files by date

        If no args, then last 10


HDOC
)
	echo "${MSG}"
}

noargs="true"

while getopts "hn:" arg; do
	case "${arg}" in
		h)
			usage
		;;

		n)
			num="${OPTARG}"
			for PTH in "${CATEGORIES[@]}"; do
				printf "--- ${KNWLGDB}/${PTH} ---\n"
				cd "${KNWLGDB}/${PTH}" && CMD2 | head -n "${num}"; done
		;;

		*)
			echo "Displaying last 10 files from all categories in: ${KNWLGDB}"
			echo "For more options/usage run with -h!"
			printf "\n"
			for PTH in "${CATEGORIES[@]}"; do
				printf "--- ${KNWLGDB}/${PTH} ---\n"
				cd "${KNWLGDB}/${PTH}" && CMD2 | head -n10; done
		;;
	esac
	noargs="false"
done


if [[ "${noargs}" == "true" ]]; then
	printf "Displaying last 10 files from all categories in: ${KNWLGDB}\n"
	printf "For more options/usage run with -h!\n"
	printf "\n"
	for PTH in "${CATEGORIES[@]}"; do
		printf "--- ${KNWLGDB}/${PTH} ---\n"
		cd "${KNWLGDB}/${PTH}" && CMD2 | head -n10; done
fi

printf "\n"

