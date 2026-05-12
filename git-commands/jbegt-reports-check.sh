#! /usr/bin/env bash
# flename: jbegt-check-reports
# last change: 20250831

echo "[INFO] checking reports for git staus commands ..."
cat $JBEGIT_STATUS_REPORTS
cat $TESTING_STATUS_REPORTS
echo "---"
echo "[INFO] checking reports for git test push commands ..."
cat $JBEGIT_TPUSH_REPORTS
cat $TESTING_TPUSH_REPORTS
echo "---"
