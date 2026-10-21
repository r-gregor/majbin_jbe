#! /usr/bin/env bash
# fname: prepare-fjl-for-knowledgebase.sh
# descpt: prepare txt-file for editing after converting from html
# 20261001 v1
# 20261021
# last: 20261021

# === GLOBALS ===
unset FJL

# === MAIN ===
if [ $# -ne 1 ]; then
    printf "[e] must supply filename as argument\n\n"
    exit 1
else
	FJL="$1"
fi

rpr="${HOME}/.local/bin/repair2-inplace-quotation-marks"
run=/usr/bin/vim

$rpr "${FJL}" &&
echo "[i] opening ${FJL} ...\n"
$run "${FJL}"

printf "\n"

