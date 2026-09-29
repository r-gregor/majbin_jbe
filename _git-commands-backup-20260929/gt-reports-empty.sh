#! /usr/bin/env bash
# flename: gt-reports-empty.sh
# descpt: Empty git reports
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

echo "[INFO] emty-ing reports for git staus commands ..."
> $GT_STATUS_REPORTS
> $TESTING_STATUS_REPORTS
echo "[INFO] checking reports for git test push commands ..."
> $GT_TPUSH_REPORTS
> $TESTING_TPUSH_REPORTS
echo "[INFO] done"

