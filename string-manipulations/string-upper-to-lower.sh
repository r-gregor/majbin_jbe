#! /usr/bin/env bash
# fname: string-upper-to-lower
# 20260331
# last: 20260331
# ---

arg="$@"

SMALL=$(echo "$arg" | sed 's/ \././' | tr [:upper:] [:lower:])

echo "$SMALL"
echo "$SMALL" | xclip   # use xclip on Linux!!

