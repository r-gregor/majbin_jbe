#! /usr/bin/env bash
# fname: string-lower-to-upper.sh
# descpt: Change string from lower to upper and store resutl ino clipboard
# 20260925
# last: 20260925
# ---

arg="$@"

BIG=$(echo "$arg" | sed 's/ \././' | tr [:lower:] [:upper:])

printf "%s\n\n" "$BIG"
printf "%s" "$BIG" | ${CLPBRDMNGR}

