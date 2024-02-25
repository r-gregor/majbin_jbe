#! /bin/bash
unixpath=$1
shift
rest="$@"

PATH_TO_FX2=$HOME/majfajls/majprogs/javafx-sdk-11.0.2/lib

# win
# java -jar --module-path $PATH_TO_FX --add-modules=javafx.controls $(cygpath -w $(realpath $unixpath)) $rest

# linux
java -jar --module-path $PATH_TO_FX2 --add-modules=javafx.controls $unixpath $rest

