#! /usr/bin/env bash
path_full="/home/gregor.redelonghi/majstaf/_NERAZPOREJENO/__DANES__/maj-fajl.txt"

path_only=${path_full%\/*}           # OK
fname_full=${path_full##*\/}         # OK
fname_base=${fname_full%%.*}         # OK
fname_ext=${fname_full##*.}          # OK

echo
echo    "Item            param subst           result"
echo    "----            -----------           ------"
echo -n 'path_full:      ${path_full}          '; echo "${path_full}"
echo -n 'path_only:      ${path_full%\/*}      '; echo "${path_full%\/*}"
echo -n 'fname_full:     ${path_full##*\/}     '; echo "${path_full##*\/}"
echo -n 'fname_base:     ${fname_full%%.*}     '; echo "${fname_full%%.*}"
echo -n 'fname_ext:      ${fname_full##*.}     '; echo "${fname_full##*.}"

echo "---"
echo 'Absolute path to script location -- NOT the current working dir: $(dirname $(realpath ${BASH_SOURCE[0]}))'
echo "$(dirname $(realpath ${BASH_SOURCE[0]}))"

echo "---"
echo "run command from script and detach from shell -- no nohup.out file:"
echo 'nohup <command> >/dev/null 2>&1 &'

echo "---"
echo -n "set IFS to newline:    "
echo "IFS=$'\n'"

echo -n "set IFS to orginal:    "
echo "IFS=$' \t\n'"

echo "---"
echo "Read output of command into array:"
echo 'cmd=$1'
echo 'output=()'
echo 'readarray -t -O ${#output[@]} output < <(cmd)'
echo ""
echo "Read contents of an array:"
echo 'for (( i=0; i<${#output[@]}; i++ )); do'
echo '	echo -e ">\t${output[$i]}"'
echo 'done'

echo "---"

