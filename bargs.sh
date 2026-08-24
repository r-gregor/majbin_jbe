#! /usr/bin/env bash
# fname:    bargs.sh
# from:     When Do Quotes Matter on The Terminal?
#           https://www.youtube.com/watch?v=w-PgWIZm5Qs
# original: https://mywiki.wooledge.org/WordSplitting
# ---
# display args to check for args expansion to avoid
# deleting important stuf ...
# 20260824 v1
# last 20260824
# ---

printf "%d args:" "$#"
[ "$#" -eq 0 ] || printf  " <%s>" "$@"
printf "\n\n"

