#! /usr/bin/env bash
# fname: fname-rename-hypens-to-underscores.sh
# descpt: rename file from hypens to underscores
# 20260929 v1
# last: 20260929
# ---

# === GLOBALS ===
ARG="$@"

# === MAIN ===
if [ "${ARG}" = "" ]; then
	printf "[e] no filename as argument\n\n"
	exit 1
else
	FNAME="$ARG"
fi

if [ ! -f "${FNAME}" ]; then
	printf "[e] no such file\n\n"
	exit 1
fi

NEW_FNAME=$(echo "${FNAME}" | sed 's/ \././' | tr '-' '_')
echo "[i] renaming ${FNAME} into ${NEW_FNAME} ..."
read -r -p "[?] ok?"

mv -v "${FNAME}" "${NEW_FNAME}"

printf "[i] done\n"

