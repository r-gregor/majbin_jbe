#! /usr/bin/env bash
# filename: clean-git-history.sh
# descpt: Clean git-history from git-repository
# 20260921 v1
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

if [ $# -ne 1 ]; then
	echo -e "[E] must supply a git repository dirname\n"
	exit
else
	read_gitdirname="$1"
fi

gitdirname="${read_gitdirname//\//}"

GHPTH="https://github.com/r-gregor/${gitdirname}.git"
GLPTH="https://gitlab.com/r-gregor/${gitdirname}.git"
GTMP="${gitdirname}_backup"

if [ ! -d "${gitdirname}" ]; then
	echo -e "[E] NO such directory: ${gitdirname}\n"
	exit
fi

if [ ! -d "${gitdirname}"/.git ]; then
	echo -e "[E] NOT a git repository\n"
	exit
fi

echo "[i] copying ${gitdirname} to ${GTMP} ..."
if [ -d "${GTMP}" ]; then
	yes | rm -rf "${GTMP}" 
fi
cp -frv "${gitdirname}" "${GTMP}"
mv "${GTMP}"/.git "${GTMP}"/dot_git

echo "[i] Trying to clean git repository in ${gitdirname}"

echo "[i] cd into ${gitdirname} ..."
cd ./"${gitdirname}" || exit 1


echo "[i] storing existing remotes into array ..."
rmts=( $(git remote) )

echo "[i] displaying remotes: "
for rmt in "${rmts[@]}"; do
	echo "remote: ${rmt}"
done

read -r -p "Proceed? "

echo "[i] creating (orphan) latest_branch ..."
git checkout --orphan latest_branch

echo "[i] adding all files/dirs to new latest_branch ..."
git add -A

echo "[i] commiting (staging) all changes to new latest_branch ..."
git commit -am "Cleanup history $(date +"%Y-%m-%d")"

echo "[i] deleting old main and creating new main branch ..."
git branch -D main
git branch -m main

echo "[i] trying to push to remotes ..."
for rmt in "${rmts[@]}"; do
	read -r -p "Force push to ${rmt} main? "
	git push -f "${rmt}" main
done

echo "[i] leaving ${gitdirname} ..."
cd ../

echo "[i] removing original git directory ..."
yes | rm -rv "${gitdirname}"

echo "[i] cloning cleaned repo from github ..."
git clone "${GHPTH}"


echo "[i] cd into cleaned ${gitdirname} ..."
cd ./"${gitdirname}" || exit 1

echo "[i] adding remotes ..."
echo "git remote add ${rmts[0]} git@github.com:r-gregor/${gitdirname}.git"
echo "git remote add ${rmts[1]} git@gitlab.com:r-gregor/${gitdirname}.git"
read -r -p "[?] Proceed? "
git remote add "${rmts[0]}" git@github.com:r-gregor/"${gitdirname}".git
git remote add "${rmts[1]}" git@gitlab.com:r-gregor/"${gitdirname}".git

echo "[i] removing autocreated remote 'origin' ..."
echo "git remote rm origin"
git remote rm origin

echo -e "[i] done\n"

