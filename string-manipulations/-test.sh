#! /usr/bin/env bash

STR="Just some string with SpApCeS .txT"
for cmd in $(find ./* -maxdepth 0 -type f | grep -v "fjls\|4-\|_test"); do echo -n "$cmd \"$STR\"  --> " && ./$cmd $STR; done
