#! /usr/bin/env bash
# fname: show-subdirs-tree.sh
# descpt: show tree of subdirs
# 20261002 v1
# last: 20261002
# ---

# set IFS to newline '\n'
nifs() {
	IFS=$'\n'
}

# set IFS to orginal ' \t\n'
oifs() {
	IFS=$' \t\n'
}

nifs

for DDD in $(find * -maxdepth 0 -type d); do
	tree --noreport --charset ASCII ${DDD}
done

oifs

