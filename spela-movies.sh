#! /bin/bash

while read line; do sudo ln -sv "$line" /home/spela/Movies/; done < <(ls -1d ~/majstaf/FILMCKI/iz_KORUZE/Movies/*)
