#! /usr/bin/env bash


# set IFS to newline '\n'
nifs() {
	echo -n "setting IFS to newline ..."
	IFS=$'\n'
	echo " done."
}

# set IFS to orginal ' \t\n'
oifs() {
	echo -n "setting IFS to original value ..."
	IFS=$' \t\n'
	echo " done."
}

nifs

for DDD in $(find * -maxdepth 0 -type d); do
	tree --noreport --charset ASCII ${DDD}
done

oifs
