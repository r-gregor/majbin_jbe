#! /usr/bin/env bash
# fname: neww.sh
# descpt: open new mintty window (without nohup.out file)
# 20261001 v1
# last: 20261001
# ---

# former left nohup.out file
# nohup /usr/bin/mintty -e /usr/bin/bash -c "~/majstaf/majbin/BrthReminder/BrthReminder_c_color.exe;cd;bash" 2> /dev/null

nohup /usr/bin/mintty -e /usr/bin/bash -c "~/majstaf/majbin/BrthReminder-c/BrthReminder-c-colors.exe;cd;bash" >/dev/null 2>&1 &

