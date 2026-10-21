#! /usr/bin/env bash
# fname: jjrun.sh
# descpt: run *.jar file with java -jar (cygwin)
# 20261001 v1
# last: 20261001
# ---

# === GLOBALS ===
unset unixpath
unset rest

# === MAIN ===
if [ $# -lt 1 ];
	printf "[e] must supply unixpath and/or options\n\n"
	exit 1
else
	unixpath="$1"
	shift
	rest="$@"
fi

java -jar $(cygpath -w $(realpath "${unixpath}")) "${rest}"

printf "\n"

