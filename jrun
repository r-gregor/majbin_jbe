#! /usr/bin/env bash
unixpath=$1
shift
rest="$@"

# cygwin on windows:
# java -jar $(cygpath -w $(realpath $unixpath)) $rest

# linux:
java -jar $unixpath $rest
