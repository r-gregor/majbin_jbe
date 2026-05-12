#! /bin/bash
unixpath=$1
shift
rest="$@"

# PATH_TO_FX=/usr/share/openjfx/lib

# linux
java -jar --module-path $PATH_TO_FX --add-modules=javafx.controls $unixpath $rest

