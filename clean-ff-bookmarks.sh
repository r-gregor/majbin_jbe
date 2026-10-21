#! /usr/bin/env bash
# filename: clean-ff-bookmarks.sh
# descpt: cleans all bookmars in bookmarks file
# 20260928
# last: 20260928
# ---

if [ $# -eq 1 ]; then
	fname=$1
else
	echo -e "Usage: $0 <bookmarks filename>\n"
	exit
fi

src=${fname}
dest="$(basename $fname .html)_cleaned.html"
echo -n "[INFO] cleaning ${src} into ${dest} ... "
sed 's/\(.*\) ADD_DATE=.*\(>.* \)/\1\2/' ${src} > ${dest}
echo "done"

if [ -f $dest ]; then
	echo "[INFO] cleaning successful ..."
	echo "[INFO] renaming src file ..."
	mv -v $fname "_brisime_${fname}"
else
	echo -e "[e] cleaning unsuccessful\n"
	exit
fi

