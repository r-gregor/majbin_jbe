#! /usr/bin/env bash
# flename: gt-reports-empty.sh
# descpt: Empty git reports
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

printf "[i] emty-ing reports for git staus commands ...\n"
> $GT_STATUS_REPORTS
> $TESTING_STATUS_REPORTS
printf "[i] checking reports for git test push commands ...\n"
> $GT_TPUSH_REPORTS
> $TESTING_TPUSH_REPORTS
printf "[i] done\n"

