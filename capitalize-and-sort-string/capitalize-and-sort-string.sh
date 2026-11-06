#! /usr/bin/env bash
# fname: capitalize-string.sh
# descpt: much faster capitalize_string() function
#         no need for external call to 'tr' for each string
# 20261106 v1
# last: 20261106
# ---


# === GLOBALS ===
dsvm_mvs_pth="${HOME}/majstaf/${HST}git/prenos/seivom/_DSVM.txt"
chk_mvs_pth="${HOME}/majstaf/majmedia/MOVIES_CHECKOUT.txt"
LINE2="TADEJA MALI REDELONGHI"
unset movies_list
declare -a movies_list

# === FUNCTIONS ===
capitalize_string() {
	unset words
	declare -a words
	while read -r STRING; do
		for WORD in $STRING ; do
			words+=( "$WORD" )
		done
	done < <(echo $1)

	printf "'"
	for (( i = 0; i < $(( ${#words[@]} - 1 )); i++ )); do
		singlew="${words[i],,}"
		printf -- "${singlew^} "
	done
	lastw="${words[$(( "${#words[@]}" - 1 ))],,}"
	printf -- "${lastw^}"
	printf "'\n"
}

# === MAIN ===
while read LINE3; do
	capitalize_string "$LINE3"
done < <(cat "${chk_mvs_pth}" | tr '[:upper:]' '[:lower:]' | sed 's/ ([0-9]\{4\})//' | sort | uniq);

printf "\n"

