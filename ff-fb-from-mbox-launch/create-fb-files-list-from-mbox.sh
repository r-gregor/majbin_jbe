#! /usr/bin/env bash
# fname: create-fb-files-list-from-mbox-mdb.sh
# v1_20260721
# last: 20260721
# ---

unset names
unset urls
unset fb_messages
unset monthnums
declare -a names
declare -a urls
declare -A fb_messages
declare -A monthnums=(["Jan"]=1 ["Feb"]=2 ["Mar"]=3 ["Apr"]=4 ["May"]=5 ["Jun"]=6 ["Jul"]=7 ["Aug"]=8 ["Sep"]=9 ["Oct"]=10 ["Nov"]=11 ["Dec"]=12)

SRCDIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
tdy=$(date +"%Y%m%d_%H%M%S")

if [ $# -ne 1 ]; then
	printf "[ERROR] no sorce *.mbox file supplied\n"
	printf "[INFO] Usage: create-fb-files-list-from-mbox <mbox file>\n\n"
	exit
else
	src="${SRCDIR}/${1}"
fi

if [ ! -f "${src}" ]; then
	printf "[ERROR] no such file: %s\n\n" "${src}"
	exit
fi

dst_local="data/fb_files_list_from_mbox.txt"
bkp_local="backups/backup_fb_files_list_from_mbox_${tdy}.txt"

dst="${SRCDIR}/${dst_local}"
fbf_backup="${SRCDIR}/${bkp_local}"

# needed as zip-ed files have WIN endings containing '\r' char
dos2unix "${src}" &> /dev/null

if [ ! -f "${dst}" ]; then
	touch "${dst}"
fi

printf "[INFO] Making backup of '%s' to '%s' ...\n" "${dst_local}" "${bkp_local}"
cp "${dst}" "${fbf_backup}"

printf "[INFO] Cleaning up '%s' ...\n" "${dst_local}"
> ${dst}

printf "[INFO] Loading info from *.mbox file into '%s' ...\n" "${dst_local}"
while read -r LINE2; do
	if [[ $LINE2 =~ "Date" ]]; then
		yr=$(echo "$LINE2" | cut -d' ' -f5)
		month=$(printf "%s" "$(echo "$LINE2" | cut -d' ' -f4)")
		mnth=${monthnums["${month}"]}
		dy=$(printf "%d" "$(echo "$LINE2" | cut -d' ' -f3)")
		tmstmp=$(printf "%d%02d%02d" "$yr" "$mnth" "$dy")
	elif [[ $LINE2 =~ "Subject" ]]; then
		fname="$(echo "$LINE2" | sed 's/Subject: //')"
		dname=$(printf "%s-%s" "${tmstmp}" "${fname}")
	elif [[ $LINE2 =~ 'https' ]]; then
		url=$(echo $LINE2 | grep -E '^https.*/$')
		if [[ $url == "" ]]; then
			continue
		fi
		printf "%s;%s\n" "${url}" "${dname}" >> ${dst}
	fi
done < "${src}"

printf "[INFO] Done!\n"

