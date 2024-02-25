#! /bin/bash
unixpath=$1
shift
rest="$@"


# win
# java -jar $(cygpath -w $(realpath $unixpath)) $rest

# linux
java -jar $unixpath $rest
