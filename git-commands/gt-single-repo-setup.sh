#! /usr/bin/env bash
# filename: gt-single-repo-setup.sh
# descpt: Single git repository setup
# 20250430
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

# globals
gh_clone_addr="https://github.com/r-gregor"
gl_clone_addr="https://gitlab.com/r-gregor"

gh_rmt_addr="git@github.com:r-gregor"
gl_rmt_addr="git@gitlab.com:r-gregor"

if [ $# -ne 1 ]; then
	echo -e [ERROR] "must supply repo name as argument\n"
	exit
else
	repo="$1"
fi

repo_name="${repo}_${HST}"

# single repo clone and setup
echo "[INFO] cloning/setting up repository: ${repo_name}"
git clone "${gh_clone_addr}/${repo_name}.git"
cd "${repo}_${HST}"

git branch -m main
git remote add "gh_${repo_name}" "${gh_rmt_addr}/${repo_name}.git"
git remote add "gl_${repo_name}" "${gl_rmt_addr}/${repo_name}.git"
git remote rm origin
git remote -v

git pull gh_${repo_name} main --set-upstream
cd ../
echo -e "[INFO] done\n"

