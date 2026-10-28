#! /usr/bin/env bash
# filename: clean-git-history.sh
# descpt: Clean git-history from git-repository
# 20260921 v1
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# 20261027
# last: 20261027
# ---

# === GLOBALS ===
unset rmts

# === FUNCTIONS ===
gt_add_remotes() {
	local git_dirname

	if [ $# -ne 1 ]; then
		printf "[e] must supply git directory name\n\n"
		exit 1
	else
		git_dirname="${1}"
	fi

	for single_remote in "${rmts[@]}"; do
		if [[ "${single_remote}" == gh* ]]; then
			git_remote_pth='git@github.com'
		elif [[ "${single_remote}" == gl* ]]; then
			git_remote_pth='git@gitlab.com'
		elif [[ "${single_remote}" == cb* ]]; then
			git_remote_pth='git@codeberg.org'
		else
			printf "[e] no such remote for current repository: '%s'\n\n" "${single_remote}"
			exit 1
		fi
		printf "\tgit remote add ${single_remote} ${git_remote_pth}:r-gregor/${git_dirname}.git\n"
		read -r -p "[?] proceed? "
		git remote add "${single_remote}" "${git_remote_pth}:r-gregor/${git_dirname}.git"
	done
}

# === MAIN ===
if [ $# -ne 1 ]; then
	printf "[e] must supply a git repository dirname\n\n"
	exit 1
else
	read_gitdirname="$1"
fi

gitdirname="${read_gitdirname//\//}"
GTMP="${gitdirname}_backup"

GHPTH="https://github.com/r-gregor/${gitdirname}.git"
GLPTH="https://gitlab.com/r-gregor/${gitdirname}.git"
CBPTH="https://codeberg.org/r-gregor/${gitdirname}.git"

if [ ! -d "${gitdirname}" ]; then
	printf "[e] no such directory: ${gitdirname}\n\n"
	exit 1
fi

if [ ! -d "${gitdirname}"/.git ]; then
	printf "[e] not a git repository: '%s'\n\n" "${gitdirname}"
	exit 1
fi

printf "[i] cleaning git repository in ${gitdirname}\n"
printf "[i] copying ${gitdirname} to ${GTMP} ... "
if [ -d "${GTMP}" ]; then
	yes | rm -rf "${GTMP}" >/dev/null
fi
cp -fr "${gitdirname}" "${GTMP}" >/dev/null
mv -v "${GTMP}"/.git "${GTMP}"/dot_git >/dev/null
printf "done\n"

printf "[i] cd into ${gitdirname} ... "
cd ./"${gitdirname}" >/dev/null || exit 1
printf "done\n"

printf "[i] displaying remotes:\n"
rmts=( $(git remote) )
for rmt in "${rmts[@]}"; do
	printf "\t${rmt}\n"
done
read -r -p "[?] proceed? "
printf "[i] creating (orphan) latest_branch:\n\t"
git checkout --orphan latest_branch >/dev/null

printf "[i] adding all files/dirs to new latest_branch ... "
git add -A >/dev/null
printf "done\n"

printf "[i] commiting (staging) all changes to new latest_branch ... "
git commit -am "Cleanup history $(date +"%Y%m%d_%HH%MM%SS")" >/dev/null
printf "done\n"

printf "[i] deleting old main and creating new main branch:\n\t"
git branch -D main
git branch -m main

# ORIGINAL
printf "[i] push to remotes:\n"
for rmt in "${rmts[@]}"; do
	read -r -p "[?] force push to ${rmt} main? "
	git push -f "${rmt}" main
	printf "\n"
done

# TEST
# printf "[i] trying to push to remotes ...\n"
# for rmt in "${rmts[@]}"; do
# 	printf "[!] current remote: '%s'\n" "$rmt"
# 	read -r -p "[?] proceed? "
# 
# 	if [[ "$rmt" == gl* || "$rmt" == gh* ]]; then
# 		read -r -p "[?] force push to ${rmt} main? "
# 		git push -f "${rmt}" main
# 	fi
# done

printf "[i] leaving ${gitdirname} ... "
cd ../
printf "done\n"

printf "[i] removing original git directory ... "
yes | rm -r "${gitdirname}" >/dev/null
printf "done\n"

printf "[i] cloning cleaned repo from github:\n"
git clone "${GHPTH}"
printf "\n"

printf "[i] cd into cleaned ${gitdirname} ... "
cd ./"${gitdirname}" || exit 1
printf "done\n"

printf "[i] adding remotes:\n"
gt_add_remotes "${gitdirname}"

printf "[i] removing auto-created remote 'origin' ... "
git remote rm origin >/dev/null
printf "done\n\n"

