#! /usr/bin/env bash
# filename: nvol-clean-git-history.sh
# descpt: Clean git-history from git-repository in 'bare' vpprs repository
# 20261026
# last: 20261026
# ---

# === GLOBALS ===
export VOLGITDIR="${HOME}/majstaf/${HST}git/vlpprs_${HST}"
export VOLWORKDIR="/c/Users/gregor.redelonghi/majstaf_${HST}/${HST}_staf/majvolpejprs"
GHPTH="git@github.com:r-gregor/vlpprs_${HST}.git"
GLPTH="git@gitlab.com:r-gregor/vlpprs_${HST}.git"
GTMP="${VOLGITDIR}_backup"

# === FUNCTIONS ===
vol_git_cmd() {
	/usr/bin/git --git-dir="${VOLGITDIR}" --work-tree="${VOLWORKDIR}" "$@"
}

# === MAIN ===
printf "[i] copying ${VOLGITDIR} to ${GTMP} ...\n"
if [ -d "${GTMP}" ]; then
	yes | rm -rf "${GTMP}"
fi
cp -frv "${VOLGITDIR}" "${GTMP}"

printf "[i] trying to clean git repository in ${VOLGITDIR}\n"
printf "[i] storing existing remotes into array ...\n"

rmts=( $(vol_git_cmd remote) )

printf "[i] displaying remotes: \n"
for rmt in "${rmts[@]}"; do
	printf "remote: ${rmt}\n"
done
read -r -p "[?] proceed? "

printf "[i] creating (orphan) latest_branch ...\n"
vol_git_cmd checkout --orphan latest_branch

printf "[i] adding all files/dirs to new latest_branch ...\n"
vol_git_cmd add -A

printf "[i] commiting (staging) all changes to new latest_branch ...\n"
vol_git_cmd commit -am "Cleanup history $(date +"%Y-%m-%d")"

printf "[i] deleting old main and creating new main branch ...\n"
vol_git_cmd branch -D main
vol_git_cmd branch -m main

printf "[i] trying to push to remotes ...\n"
for rmt in "${rmts[@]}"; do
	read -r -p "[?] force push to ${rmt} main? "
	vol_git_cmd push -f "${rmt}" main
done

printf "[i] leaving ${gitdirname} ...\n"
cd ../

printf "[i] removing original git directory ...\n"
yes | rm -rv "${gitdirname}"

printf "[i] cloning cleaned repo from github ...\n"
vol_git_cmd clone "${GHPTH}"


printf "[i] cd into cleaned ${gitdirname} ...\n"
cd ./"${gitdirname}" || exit 1

printf "[i] adding remotes ...\n"
printf "git remote add ${rmts[0]} git@github.com:r-gregor/${gitdirname}.git\n"
printf "git remote add ${rmts[1]} git@gitlab.com:r-gregor/${gitdirname}.git\n"
read -r -p "[?] proceed? "
vol_git_cmd remote add "${rmts[0]}" git@github.com:r-gregor/"${gitdirname}".git
vol_git_cmd remote add "${rmts[1]}" git@gitlab.com:r-gregor/"${gitdirname}".git

printf "[i] removing autocreated remote 'origin' ...\n"
printf "[i] git remote rm origin\n"
vol_git_cmd remote rm origin

printf "[i] done\n"

