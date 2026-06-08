#! /usr/bin/env bash
# fname: lynxd-url.sh
# v1_20260605
# v2 20260608 corrected if URL ends with '/'
# last 20260608
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

if [[ ${URL:${#URL}-1} == "/" ]]; then
	FINAL_URL=${URL:1:${#URL}-2}
else
	FINAL_URL=${URL}
fi

# TEST
# printf "final URL: $FINAL_URL\n"
# read -p "OK?"

if [[ ${prefix} == 0 ]]; then
	fname=$(echo "${FINAL_URL##*/}" | tr '_' '-' | tr '[[:upper:]]' '[[:lower:]]' | sed 's/-in-c//g')
else
	fname=$(echo "${prefix}-${FINAL_URL##*/}" | tr '_' '-' | tr '[[:upper:]]' '[[:lower:]]' | sed 's/-in-c//g')
fi

dest="${fname}-${danes}.txt"

# TEST
# printf "dest: %s\n" "${dest}"
# read -p "OK?"

if [[ -f "${dest}" ]]; then
	printf "[ERROR] file: '%s' exists\n\n" "${dest}"
	exit
fi

echo "filename: ${dest}" >> ${dest}
echo -e "${URL}\n\n" >> ${dest}
lynx -dump -width=110 ${URL} >> "${dest}"
printf "\n\n---\n" >> ${dest}
printf "[INFO] fname created: '%s'\n\n" "${dest}"

