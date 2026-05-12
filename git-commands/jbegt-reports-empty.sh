#! /usr/bin/env bash
# flename: jbegt-empty-reports
# last change: 20250831

echo "[INFO] emty-ing reports for git staus commands ..."
> $JBEGIT_STATUS_REPORTS
> $TESTING_STATUS_REPORTS
echo "[INFO] checking reports for git test push commands ..."
> $JBEGIT_TPUSH_REPORTS
> $TESTING_TPUSH_REPORTS
echo "[INFO] done"

