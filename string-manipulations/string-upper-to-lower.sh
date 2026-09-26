#! /usr/bin/env bash
# fname: string-upper-to-lower.sh
# descpt: Change upper to lower and store result in clpboard
# 20260925
# last: 20260925
# ---

arg="$@"

SMALL=$(echo "$arg" | sed 's/ \././' | tr [:upper:] [:lower:])

printf "%s\n\n" "$SMALL"
printf "%s" "$SMALL" | ${CLPBRDMNGR}

