#! /usr/bin/env bash
# fname: # 20260911 v1
# ---

PREFIX="."
HST=jbe
TMSTMP=$(date +"%Y%m%d-%H%M%S")
DESTF="${PREFIX}/dot-vimrc-${HST}-mappings-with-explanations-${TMSTMP}.txt"

touch "${DESTF}"
(printf -- "Mappings from .vimrc (%s): %s\n---\n" "${HST}" "${TMSTMP}") >> "${DESTF}"

cat ~/.vimrc | grep -B1 '^[a-z]*map' >> "${DESTF}"
(printf -- "\" ---\n\n") >> "${DESTF}"

