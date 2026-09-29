#! /usr/bin/env bash
# flename: gt-check-reports
# descpt: Check git reports
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

printf "[i] checking reports for git staus commands ...\n"
cat $GT_STATUS_REPORTS
cat $TESTING_STATUS_REPORTS
printf -- "---\n"
echo "[i] checking reports for git test push commands ..."
cat $GT_TPUSH_REPORTS
cat $TESTING_TPUSH_REPORTS
printf -- "---\n"
