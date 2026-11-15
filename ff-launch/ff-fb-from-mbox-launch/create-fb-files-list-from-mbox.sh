#! /usr/bin/env bash
# fname: create-fb-files-list-from-mbox-mdb.sh
# descpt: create fb-links file from mbox file
# v2_20261115
# last: 20261115
# ---
# === GLOBALS ===
unset names
unset urls
unset fb_messages
unset monthnums
declare -a names
declare -a urls
declare -A fb_messages
declare -A monthnums=(["Jan"]=1 ["Feb"]=2 ["Mar"]=3 ["Apr"]=4 ["May"]=5 ["Jun"]=6 ["Jul"]=7 ["Aug"]=8 ["Sep"]=9 ["Oct"]=10 ["Nov"]=11 ["Dec"]=12)

SRCDIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
storage_local="data"
storage_custom="custom_fbfl_data"
storage_backups="backups"
NOW=$(date +"%Y%m%d_%H%M%S")

fbfl_local_path="${storage_local}/fb_files_list_from_mbox.txt"
fbfl_backups="${storage_backups}/backup_fb_files_list_from_mbox_${NOW}.txt"
fbfl_backups_path="${SRCDIR}/${fbfl_backups}"

# === FUNCTIONS ===
backup_data_fbfl() {
	dst="${SRCDIR}/${fbfl_local_path}"

	if [ -s "${dst}" ]; then
		printf "[i] making backup of '%s' to '%s' ...\n" "${fbfl_local_path}" "${fbfl_backups}"
		cp "${dst}" "${fbfl_backups_path}"
		printf "[i] cleaning up '%s' ...\n" "${fbfl_local_path}"
		> "${dst}"
	else
		printf "[i] creating '%s' ..." "${dst}"
		touch "${dst}"
		printf " done\n"
	fi
}

create_fb_files_list() {
	dos2unix "${src}" &> /dev/null

	if [ ! -f "${dst}" ]; then
		touch "${dst}"
	fi

	printf "[i] loading info from *.mbox file into '%s' ...\n" "${storage_dir}/${dst##*/}"
	while read -r LINE2; do
		if [[ $LINE2 =~ "Date" ]]; then
			yr=$(echo "${LINE2}" | cut -d' ' -f5)
			month=$(printf "%s" "$(echo "${LINE2}" | cut -d' ' -f4)")
			mnth="${monthnums["${month}"]}"
			dy=$(printf "%d" "$(echo "${LINE2}" | cut -d' ' -f3)")
			tmstmp=$(printf "%d%02d%02d" "$yr" "${mnth}" "${dy}")
		elif [[ "${LINE2}" =~ "Subject" ]]; then
			fname="$(echo "${LINE2}" | sed 's/Subject: //')"
			dname=$(printf "%s-%s" "${tmstmp}" "${fname}")
		elif [[ "${LINE2}" =~ 'https' ]]; then
			url=$(echo "${LINE2}" | grep -E '^https.*/$')
			if [[ "${url}" == "" ]]; then
				continue
			fi
			printf "%s;%s\n" "${url}" "${dname}" >> "${dst}"
		fi
	done < "${src}"
}

# === MAIN ===
if [ ! -d "${SRCDIR}/${storage_local}" ]; then
	printf "[!] no such directory: '%s', creating ..." "${storage_local}"
	mkdir "${SRCDIR}/${storage_local}" 2>/dev/null 1>&2
	printf " done\n"
fi

if [ $# -ne 1 ]; then
	printf "[e] no source *.mbox file supplied\n"
	printf "[i] Usage: create-fb-files-list-from-mbox <mbox file>\n\n"
	exit 1
else
	src="${SRCDIR}/${1}"
fi

if [ ! -f "${src}" ]; then
	printf "[e] no such file: %s\n\n" "${src}"
	exit 1
fi

read -r -p "[?] create custom destination file (y/Y or n/N)? " ans

case "${ans}" in
	y|Y)
		if [ ! -d "${SRCDIR}/${storage_custom}" ]; then
			printf "[!] no such directory: '%s', creating ..." "${storage_custom}"
			mkdir "${SRCDIR}/${storage_custom}" 2>/dev/null 1>&2
			printf " done\n"
		fi
		read -r -p "[?] filename: " dst_custom_fname
		dst="${SRCDIR}/${storage_custom}/${dst_custom_fname}_${NOW}.txt"
		if [ -f "${dst}" ]; then
			printf "[!] file '%s' exists -- choose another file name" "${dst}"
			exit 1
		else
			create_fb_files_list
		fi
	;;
	
	n/N)
		backup_data_fbfl
		create_fb_files_list
	;;

	*)
		backup_data_fbfl
		create_fb_files_list
	;;
esac

printf "[i] done\n\n"

