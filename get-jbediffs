#! /usr/bin/env bash
# get_jbediffs
# last change 20240822_d

USR="jbe"
CURRDIR=$PWD
MJSTFJBE=${HOME}/majstaf
MJSTFJBE_G=${MJSTFJBE}/${USR}git
TMPF="${HOME}/.tmp/getd_tmp"


cd ${MJSTFJBE_G}/dotfiles_${USR}
echo "[INFO] diffs: dotfiles_en ..."
touch $TMPF
for FFF in $(ls -1A); do diff -qr $FFF ${HOME}/${FFF} 2>/dev/null | grep -iv 'only' | grep -v '.git' >> $TMPF; done
output=$(cat $TMPF | head -c1 | wc -c)
if [ $output -ne 0 ]; then
	while read LINE; do
		printf "\t$LINE\n"
	done < $TMPF
	printf "\n"
fi
rm $TMPF 2>/dev/null

for check_dir in majbin majrcs metsys; do
	cd ${MJSTFJBE_G}/${check_dir}_${USR}
	echo "[INFO] diffs: ${check_dir} ..."
	touch $TMPF
	for FFF in $(ls -1); do diff -qr $FFF ${MJSTFJBE}/${check_dir}/${FFF} | grep -iv 'only' >> $TMPF; done
	output2=$(cat $TMPF | head -c1 | wc -c)
	if [ $output2 -ne 0 ]; then
		while read LINE; do
			printf "\t$LINE\n"
		done < $TMPF
		printf "\n"
	fi
	rm $TMPF 2>/dev/null
	cd $HOME
done

cd ${CURRDIR}

