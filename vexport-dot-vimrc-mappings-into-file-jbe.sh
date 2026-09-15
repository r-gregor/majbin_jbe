#! /usr/bin/env bash
# fname: vexport-dot-vimrc-mappings-into-file-jbe.sh
# 20260915 v2 added check for program parameters and check for PREFIX existance
# last: 20260915
# ---

if [ $# -ne 1 ]; then
	PREFIX="."
else
	PREFIX="${1}"
fi

if [ ! -d "${PREFIX}" ]; then
	printf "[ERROR] no such directory/dest: '%s'\n\n" "${PREFIX}"
	exit 1
fi



HST=jbe
TMSTMP=$(date +"%Y%m%d-%H%M%S")
DESTF="${PREFIX}/dot-vimrc-${HST}-mappings-with-explanations-${TMSTMP}.txt"

touch "${DESTF}"
(printf -- "Mappings from .vimrc (%s): %s\n---\n" "${HST}" "${TMSTMP}") >> "${DESTF}"

cat ~/.vimrc | grep -B1 '^[a-z]*map' >> "${DESTF}"
(printf -- "\" ---\n\n") >> "${DESTF}"

printf "[INFO] ~/.vimrc mappings succesfully exported to ${DESTF}\n\n"
