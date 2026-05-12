#! /usr/bin/env bash
# check_if_mvs_in_both_dirs.sh
# 20240422_d:  - added check if parameter is 4-digit year
#              - and 'all' as parameter to check all durectories
# 20240423_en: - (or) logical operator in checking for dirs"


if [ $# -ne 1 ]; then
	echo -e "Must supply year or 'all' as argument\n"
	exit
else
	YR=$1
fi


if [ ! -d "${PWD}/Movies" ] || [ ! -d "${PWD}/Seivom" ]; then
	echo -e "There is no 'Movies' or 'Seivom' directories!\n"
	exit
fi

# set IFS to newline
IFS=$'\n'

if [[ $YR =~ [[:digit:]]{4} ]] && [ ${#YR} -eq 4 ]; then
	fname="*(${YR})"

	# test
	# echo "fname: $fname"
elif [ $YR == "all" ]; then
	fname='*'

	# test
	# echo "fname: $fname"
else
	echo -e "No suitable parameter\n"
	exit
fi

# echo "List of movies that are in both dirs: Movies and Seivom"
for VSM in $(find ./Seivom/ -type d -name "$fname"); do
	for MVS in $(find ./Movies/ -type d -name "$fname"); do
		if [ $(basename $MVS) == $(basename $VSM) ]; then

			#test
			# echo "$(basename $MVS)"
			echo "$MVS : $VSM"
		fi
	done
done

# set ifs to original
IFS=$' \t\n'

