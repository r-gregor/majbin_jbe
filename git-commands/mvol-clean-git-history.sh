#! /usr/bin/env bash
# filename: mvol-clean-git-history.sh
# descpt: Clean git-history from git-repository in 'bare' vpprs repository
# 20261026
# 20261029
# last: 20261029
# ---

# === GLOBALS ===
export VOLGITDIR="${HOME}/majstaf/${HST}git/vlpprs_${HST}.git"
export VOLWORKDIR="${HOME}/majstaf/majvolpejpers"
GHPTH="git@github.com:r-gregor/vlpprs_${HST}.git"
GLPTH="git@gitlab.com:r-gregor/vlpprs_${HST}.git"
GTMP="${VOLGITDIR}_backup"
git_dirname="vlpprs_${HST}.git"

# === FUNCTIONS ===
vol_git_cmd() {
	/usr/bin/git --git-dir="${VOLGITDIR}" --work-tree="${VOLWORKDIR}" "$@"
}

vol_git_add_remotes() {
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
		# git remote add "${single_remote}" "${git_remote_pth}:r-gregor/${git_dirname}.git"
        vol_git_cmd remote add "${single_remote}" "${git_remote_pth}:r-gregor/${git_dirname}.git"
	done
}

# === MAIN ===
cd "${VOLGITDIR}"
printf "[i] cleaning git repository in ${gitdirname}\n"
printf "[i] copying ${VOLGITDIR} to ${GTMP} ... "
if [ -d "${GTMP}" ]; then
	yes | rm -rf "${GTMP}" > /dev/null
fi
cp -frv "${VOLGITDIR}" "${GTMP}" > /dev/null
printf "done\n"

printf "[i] displaying remotes: \n"
rmts=( $(vol_git_cmd remote) )
for rmt in "${rmts[@]}"; do
	printf "\t${rmt}\n"
done
read -r -p "[?] proceed? "

printf "[i] creating (orphan) latest_branch\n\t"
vol_git_cmd checkout --orphan latest_branch > /dev/null

printf "[i] adding all files/dirs to new latest_branch ... "
vol_git_cmd add -A >/dev/null
printf "done\n"

printf "[i] commiting (staging) all changes to new latest_branch ... "
vol_git_cmd commit -am "Cleanup history $(date +"%Y-%m-%d")" > /dev/null
printf "done\n"

printf "[i] deleting old main and creating new main branch:\n\t"
vol_git_cmd branch -D main
vol_git_cmd branch -m main

printf "[i] push to remotes:\n"
for rmt in "${rmts[@]}"; do
	read -r -p "[?] force push to ${rmt} main? "
	vol_git_cmd push -f "${rmt}" main
	printf "\n"
done

printf "[i] leaving ${gitdirname} ... "
cd ../
printf "done\n"

printf "[i] removing original git directory ...\n"
yes | rm -rv "${VOLGITDIR}" > /dev/null
printf "done\n"

printf "[i] cloning cleaned repo from github ...\n"
vol_git_cmd clone --bare "${GHPTH}"
printf "\n"

# printf "[i] cd into cleaned ${gitdirname} ... "
# cd ./"${gitdirname}" || exit 1
# printf "done\n"

printf "[i] adding remotes:\n"
vol_git_add_remotes

printf "[i] removing autocreated remote 'origin' ... "
vol_git_cmd remote rm origin > /dev/null
printf "done\n\n"

