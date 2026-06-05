#! /usr/bin/env bash
# fname: lynxd-url.sh
# v1_20260605
# ---

danes=$(date +"%Y%m%d")

usage() {
    cat <<EOF

    Usage: lynxd-url <"URL"> <prefix>
                       URL:    between double quotes ("https://...")
                       prefix: cathegory (c, ptn, jv, go, ...)
                               if no cathegory: prefix == '0'

EOF
}

if [ $# -ne 2 ]; then
	usage
	exit
else
	URL="${1}"
	prefix="${2}"
fi

if [[ ${prefix} == "0" ]]; then
	fname=$(echo "${URL##*/}" | tr '_' '-' | tr '[[:upper:]]' '[[:lower:]]' | sed 's/-in-c//g')
else
	fname=$(echo "${prefix}-${URL##*/}" | tr '_' '-' | tr '[[:upper:]]' '[[:lower:]]' | sed 's/-in-c//g')
fi

dest="${fname}-${danes}.txt"

if [[ -f "${dest}" ]]; then
	printf "[ERROR] file: '%s' exists\n\n" "${dest}"
	exit
fi

lynx -dump -width=110 ${URL} >> "${dest}"
printf "\n\n---\n" >> ${dest}
printf "[INFO] done\n\n"

