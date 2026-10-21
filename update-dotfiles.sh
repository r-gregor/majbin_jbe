#! /usr/bin/env bash

echo "[i] updating ~/majstaf/mdbgit/dotfiles_mdb ..."

CURRDIR=$PWD
cd ${HOME}/majstaf/mdbgit/dotfiles_mdb
for DDD in $(ls -1A | grep -v '.git'); do
	cp -rfv ~/$DDD .
done

cd ${CURRDIR}

