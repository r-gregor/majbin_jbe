#! /usr/bin/env bash

if [ $# -ne 1 ]; then
    echo -e "Usage $0 [year in YYYY format]\n"
    exit 1
fi

YEAR=$1

lns=$(ls | grep "_${YEAR}" | wc -l)

if [ $lns -lt 1 ]; then
    echo -e "No results for year: ${YEAR}!\n"
    exit 1
fi


clear; for line in $(ls | grep "_${YEAR}"); do let lns=$lns-1; echo -e "$line ($lns more ...)"; read -p ""; clear; done
