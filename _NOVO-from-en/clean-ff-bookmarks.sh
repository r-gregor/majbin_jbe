#! /usr/bin/env bash

if [ $# -eq 1 ]; then
	fname=$1
else
	echo -e "Usage: $0 <bookmarks filename>\n"
	exit
fi

src=${fname}
dest="$(basename $fname .html)_cleaned.html"
echo -n "[i] cleaning ${src} into ${dest} ... "
sed 's/\(.*\) ADD_DATE=.*\(>.* \)/\1\2/' ${src} > ${dest}
echo "done"

if [ -f $dest ]; then
	echo "[i] cleaning successful ..."
	echo "[i] renaming src file ..."
	mv -v $fname "_brisime_${fname}"
else
	echo -e "[E] cleaning unsuccessful -- aborting\n"
	exit
fi

