#! /usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "Usage $0 [year in YYYY format]"
    exit 1
fi

YEAR=$1

lns=$(ls | grep "_${YEAR}" | wc -l)

if [ $lns -lt 1 ]; then
    echo "No results for year: ${YEAR}!"
    exit 1
fi


clear; for line in $(ls | grep "_${YEAR}"); do let lns=$lns-1; echo -e "$line ($lns more ...)"; read -p ""; clear; done
