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

cat << EOF1

	***
	Description:
	readarray [-d delimiter] [-n count] [-O origin] [-s count] [-t] [-u fd] myArr
	
	   where,
	-d delimiter: Specifies a delimiter character to use instead of the newline character.
	-n: Copy at most the specified number of lines. All the lines are copied if the count is set to 0.
	-O: Assigning to the array at index origin. By default the index kept 0.
	-s: Let go of the first count lines read.
	-t: Remove a trailing delimiter from each line read. The default value is a newline.
	-u: Read lines from file descriptor fd instead of the standard input.
	myArr: Name of the array to be declared.
	***

EOF1

echo ""
echo "Read contents of an array:"
echo 'for (( i=0; i<${#output[@]}; i++ )); do'
echo '	echo -e ">\t${output[$i]}"'
echo 'done'

cat <<EOF2

---
single-line example:
$> readarray -t dirs < <(ls -dA *)
$> for ((i=0;i<${#dirs[@]};i++)); do printf "dir %02d: %s\n" $[i+1] ${dirs[$i]}; done
dir 01: _NERAZPOREJENO
dir 02: coding2
dir 03: dev
.
.
.

EOF2
echo "---"

