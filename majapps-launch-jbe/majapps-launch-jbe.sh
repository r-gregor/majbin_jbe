#! /usr/bin/env bash
# filename: majapps-launch-jbe
# 20250917 v1
# 20251020 v2 run inside infinite loop and added 'q' to quit
#             keys in separate index-ed array to keep display order
#             added slelection_info() function
#             $delline calculated from longest KEY line with get_longest function
#             sorted output to fzf command
#             extract KEYS from URLS
# 20260423 v3 put all RUN statemnets into majapps_run() function and add option to select input as parameter
# 20260423 v4 selected input as parameter into array, if multiple option to redefine parameter
# 20260507 v5 move selection var with fzf into get_selection_jbe() function
# 20260511 v6 move links to external (csv format with ';' delimiter) file and add load_links_into_array()
#             function to load links from file into associative array
# last: 20260511
# ---

# clear the screen:
printf "\033[H\033[2J"

# globals
SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
FNAME="majapps_links_list_jbe" # v7
FPTH=${SRCDIR}/${FNAME}         # v7

# assoc array
declare -A majapps


# functions
# v6
load_links_into_array() {
	while IFS=';' read key value; do
		majapps["${key}"]="${value}"
	done < "${FPTH}"
}

get_longest() {
	if [ ! $# -eq 1 ]; then
		echo "[ERROR1] must supply array of sentences as parameter"
		exit 1
	fi

	local len=0
	local longest
	local -n lines2=$1 # new way: must call array as < array_name >

	for line in "${lines2[@]}"; do
		llen="${#line}"
		if [ "${llen}" -gt "${len}" ]; then
			len="${llen}"
			longest="${line}"
		else
			continue
		fi
	done

	echo "${longest}"
}

selection_info() {
	printf "[INFO] selected: $1\n"
}

# v3
majapps_run() {
	if [ "x${selection}" == "x" ]; then
		echo -e "[INFO] no selection\n"
		exit
	fi

	if [ "${selection}" == "${delline}" ]; then #v3
		continue
	fi

	if [ "${selection}" == "Quit" ]; then
		exit
	fi

	eval "nohup ${majapps["${selection}"]} >&/dev/null &"
	selection_info "${selection}"
}

# v5
get_selection_jbe() {
	# add +c option to reverse highlight
	# selection=$( for key in "${!keys[@]}"; do echo "${keys[$key]}"; done | \
	selection=$((for key in "${!keys[@]}"; do echo "${keys[$key]}"; done | sort; echo "${delline}"; echo "Quit") | \
				fzf -e \
				--reverse \
				--border=rounded \
				--info=hidden \
				--prompt="launch: ")
}

# v5
# for testing in Cygwin:
get_selection_en() {
	selection=$((for key in "${!keys[@]}"; do echo "${keys[$key]}"; done | sort; echo "${delline}"; echo "Quit") | \
		fzf \
		-e \
		--reverse \
		-i \
		--prompt="launch: ")
}

# MAIN (v3)
load_links_into_array # v6

# array of keys from majapps
keys=("${!majapps[@]}")

longest_l=$(get_longest keys)                                         # v3
delline=$(for((i = 0; i < ${#longest_l}; i++)); do printf "-"; done)  # v3

# v4
if [ $# -eq 1 ]; then
	declare -a options
	# ${varname,,} -- convert string to all lowercase ...
	for key in "${keys[@]}"; do
		if [[ "${key,,}" =~ "${1,,}" ]]; then
			options+=("${key}")
		fi
	done

	if [ "${#options[@]}" -gt 1 ]; then
		printf "[ERROR] multiple selections:\n"
		for OPT in "${options[@]}"; do
			printf "${OPT}\n"
		done
		printf "[INFO] redefine parameter\n\n"
		exit
	elif [ "${#options[@]}" -eq 0 ]; then
		printf "[ERROR] no selection\n\n"
		exit
	else
		selection="${options[0]}"
	fi

	read -p "[INFO] launch: ${selection} ... OK?"
	majapps_run
	exit
fi



# v5
while true; do
	# for testing in Cygwin:
	# get_selection_en
	get_selection_jbe
	majapps_run
done

