#! /usr/bin/env bash

if [ $# -ne 1 ]; then
	echo "[ERROR] must supply a git repository dirname"
	exit
else
	read_gitdirname=$1
fi

gitdirname=${read_gitdirname//\//}

GHPTH="https://github.com/r-gregor/${gitdirname}.git"
GLPTH="https://gitlab.com/r-gregor/${gitdirname}.git"
GTMP="${gitdirname}_backup"

if [ ! -d ${gitdirname} ]; then
	echo "[ERROR] NO such directory: ${gitdirname}"
	exit
fi

if [ ! -d ${gitdirname}/.git ]; then
	echo "[ERROR] NOT a git repository"
	exit
fi

echo "[INFO] copying ${gitdirname} to ${GTMP} ..."
if [ -d ${GTMP} ]; then
	yes | rm -rf ${GTMP}
fi
cp -frv ${gitdirname} ${GTMP}
mv ${GTMP}/.git ${GTMP}/dot_git

echo "[INFO] Trying to clean git repository in ${gitdirname}"

echo "[INFO] cd into ${gitdirname} ..."
cd ${gitdirname}


echo "[INFO] storing existing remotes into array ..."
rmts=( $(git remote) )

echo "[INFO] displaying remotes: "
for rmt in "${rmts[@]}"; do
	echo "remote: ${rmt}"
done

read -p "Proceed? "

echo "[INFO] creating (orphan) latest_branch ..."
git checkout --orphan latest_branch

echo "[INFO] adding all files/dirs to new latest_branch ..."
git add -A

echo "[INFO] commiting (staging) all changes to new latest_branch ..."
git commit -am "Cleanup history $(date +"%Y-%m-%d")"

echo "[INFO] deleting old main and creating new main branch ..."
git branch -D main
git branch -m main

echo "[INFO] trying to push to remotes ..."
for rmt in "${rmts[@]}"; do
	read -p "Force push to ${rmt} main? "
	git push -f ${rmt} main
done

echo "[INFO] leaving ${gitdirname} ..."
cd ../

echo "[INFO] removing original git directory ..."
yes | rm -rv ${gitdirname}

echo "[INFO] cloning cleaned repo from github ..."
git clone ${GHPTH}


echo "[INFO] cd into cleaned ${gitdirname} ..."
cd ${gitdirname}

echo "[INFO] adding remotes ..."
echo "git remote add ${rmts[0]} git@github.com:r-gregor/${gitdirname}.git"
echo "git remote add ${rmts[1]} git@gitlab.com:r-gregor/${gitdirname}.git"
read -p "Proceed? "
git remote add ${rmts[0]} git@github.com:r-gregor/${gitdirname}.git
git remote add ${rmts[1]} git@gitlab.com:r-gregor/${gitdirname}.git

echo "[INFO] removing autocreated remote 'origin' ..."
echo "git remote rm origin"
git remote rm origin

echo "[INFO] done"

