#! /usr/bin/env bash
# fname: capitalize-and-sort-string.sh
# descpt: much faster capitalize_string() function
#         no need for external call to 'tr' for each string
# 20261106 v1
# 20261106 v2: some corrections after shellcheck
# last: 20261106
# ---

# === GLOBALS ===
chk_mvs_pth="${HOME}/majstaf/majmedia/MOVIES_CHECKOUT.txt"

# === FUNCTIONS ===
capitalize_string() {
	unset words
	declare -a words
	while read -r STRING; do
		for WORD in $STRING ; do
			words+=( "$WORD" )
		done
	done < <(echo "$1")

	printf "'"
	for (( i = 0; i < $(( ${#words[@]} - 1 )); i++ )); do
		singlew="${words[i],,}"
		printf -- "%s " "${singlew^}"
	done
	lastw="${words[$(( "${#words[@]}" - 1 ))],,}"
	printf -- "%s" "${lastw^}"
	printf "'\n"
}

# === MAIN ===
while read -r LINE3; do
	capitalize_string "$LINE3"
# done < <(cat "${chk_mvs_pth}" | tr '[:upper:]' '[:lower:]' | sed 's/ ([0-9]\{4\})//' | sort | uniq);
done < "${chk_mvs_pth}" | tr '[:upper:]' '[:lower:]' | sed 's/ ([0-9]\{4\})//' | sort | uniq

printf "\n"

