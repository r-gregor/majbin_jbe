#! /usr/bin/env bash
# filename: clean-git-history.sh
# descpt: Clean git-history from git-repository
# 20260921 v1
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

if [ $# -ne 1 ]; then
	printf "[E] must supply a git repository dirname\n"
	exit
else
	read_gitdirname="$1"
fi

gitdirname="${read_gitdirname//\//}"

GHPTH="https://github.com/r-gregor/${gitdirname}.git"
GLPTH="https://gitlab.com/r-gregor/${gitdirname}.git"
GTMP="${gitdirname}_backup"

if [ ! -d "${gitdirname}" ]; then
	printf "[E] NO such directory: ${gitdirname}\n"
	exit
fi

if [ ! -d "${gitdirname}"/.git ]; then
	printf "[E] NOT a git repository\n"
	exit
fi

printf "[i] copying ${gitdirname} to ${GTMP} ...\n"
if [ -d "${GTMP}" ]; then
	yes | rm -rf "${GTMP}" 
fi
cp -frv "${gitdirname}" "${GTMP}"
mv "${GTMP}"/.git "${GTMP}"/dot_git

printf "[i] Trying to clean git repository in ${gitdirname}\n"

printf "[i] cd into ${gitdirname} ...\n"
cd ./"${gitdirname}" || exit 1


printf "[i] storing existing remotes into array ...\n"
rmts=( $(git remote) )

printf "[i] displaying remotes: \n"
for rmt in "${rmts[@]}"; do
	printf "remote: ${rmt}\n"
done

read -r -p "[?] Proceed? "

printf "[i] creating (orphan) latest_branch ...\n"
git checkout --orphan latest_branch

printf "[i] adding all files/dirs to new latest_branch ...\n"
git add -A

printf "[i] commiting (staging) all changes to new latest_branch ...\n"
git commit -am "Cleanup history $(date +"%Y-%m-%d")"

printf "[i] deleting old main and creating new main branch ...\n"
git branch -D main
git branch -m main

printf "[i] trying to push to remotes ...\n"
for rmt in "${rmts[@]}"; do
	read -r -p "[?] Force push to ${rmt} main? "
	git push -f "${rmt}" main
done

printf "[i] leaving ${gitdirname} ...\n"
cd ../

printf "[i] removing original git directory ...\n"
yes | rm -rv "${gitdirname}"

printf "[i] cloning cleaned repo from github ...\n"
git clone "${GHPTH}"


printf "[i] cd into cleaned ${gitdirname} ...\n"
cd ./"${gitdirname}" || exit 1

printf "[i] adding remotes ...\n"
printf "git remote add ${rmts[0]} git@github.com:r-gregor/${gitdirname}.git\n"
printf "git remote add ${rmts[1]} git@gitlab.com:r-gregor/${gitdirname}.git\n"
read -r -p "[?] Proceed? "
git remote add "${rmts[0]}" git@github.com:r-gregor/"${gitdirname}".git
git remote add "${rmts[1]}" git@gitlab.com:r-gregor/"${gitdirname}".git

printf "[i] removing autocreated remote 'origin' ...\n"
printf "[i] git remote rm origin\n"
git remote rm origin

printf "[i] done\n"

