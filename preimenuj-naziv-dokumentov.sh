#! /usr/bin/env bash
# fname: preimenuj-naziv-dokumentov.sh
# descpt: rename part of filename with pattern for ALL '*.doc*', '*.xls*' and "*.txt' files in currdir
# 20261001 v1
# 20261021
# last: 20261021


# === MAIN ===
if [ $# -ne 2 ]; then
	printf "[i] rename ALL '*.doc*', '*.xls*' or '*.txt' files -- switch patterns\n"
	printf "[i] Usage: preimenuj-naziv-dokumentov [old-file-name-pattern] [new-file-name-pattern]\n"
	printf "\n"
    printf "       01a_pretavitev-Valvasorjeva-PID_NASLOVNA-STRAN.docx\n"
    printf "           ^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
	printf "\n"
	exit 1
fi

old="$1"
new="$2"

printf "[i] dry run ...\n"
for FFF in $(find * -maxdepth 0 -name "*\.doc*" -o -name "*\.xls*" -o -name "*\.txt"); do
	oldF="${FFF}"
	newF="${FFF//"${old}"/"${new}"}"
	printf "${oldF} --> ${newF}\n"
done

read -r -p "[?] continue? (yes/YES) " ANS

if [[ "$ANS" == "yes" || "$ANS" == "YES" ]]; then
	for FFF in $(find * -maxdepth 0 -name "*\.doc*" -o -name "*\.xls*" -o -name "*\.txt"); do
		oldF="${FFF}"
		newF="${FFF//"${old}"/"${new}"}"
		mv -v "${oldF}" "${newF}"
	done
else
	printf "[e] no confirmation -- leaving\n\n"
	exit 1
fi

printf "[i] done\n\n"

