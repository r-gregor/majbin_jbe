#! /usr/bin/env bash
# filename: gt-dest-src-diffs.sh
# descpt: check for diff-s of all files in git-repository with original files
# 20260924
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

CURRDIR=$PWD
MJSTFMDB=${HOME}/majstaf
MJSTFMDB_G=${MJSTFMDB}/${HST}git
TMPF="${HOME}/.tmp/getd_tmp"


cd ${MJSTFMDB_G}/dotfiles_${HST}
printf "[i] diffs: dotfiles_en ...\n"
touch $TMPF
for FFF in $(ls -1A); do diff -qr $FFF ${HOME}/${FFF} 2>/dev/null | grep -iv 'only' | grep -v '.git' >> $TMPF; done
output=$(cat $TMPF | head -c1 | wc -c)
if [ $output -ne 0 ]; then
	while read -r LINE; do
		printf "\t$LINE\n"
	done < $TMPF
	printf "\n"
fi
rm $TMPF 2>/dev/null

for check_dir in majbin majrcs metsys; do
	cd ${MJSTFMDB_G}/${check_dir}_${HST}
	printf "[i] diffs: ${check_dir} ...\n"
	touch $TMPF
	for FFF in $(ls -1); do diff -qr $FFF ${MJSTFMDB}/${check_dir}/${FFF} | grep -iv 'only' >> $TMPF; done
	output2=$(cat $TMPF | head -c1 | wc -c)
	if [ $output2 -ne 0 ]; then
		while read -r LINE; do
			printf "\t$LINE\n"
		done < $TMPF
		printf "\n"
	fi
	rm $TMPF 2>/dev/null
	cd $HOME
done

cd ${CURRDIR}

