#! /usr/bin/env bash
# fname: nvol-push-all.sh
# descpt: Push to majvolpejprs remotes
# 20240823
# 20260925: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260925
# ---

export VOLGITDIR="${HOME}/majstaf/${HST}git/vlpprs_${HST}"
export VOLWORKDIR="/c/Users/gregor.redelonghi/majstaf_${HST}/${HST}_staf/majvolpejprs"
git_nvol="/usr/bin/git --git-dir=${VOLGITDIR} --work-tree=${VOLWORKDIR}"

ghvol="git@github.com:r-gregor/vlpprs_${HST}.git"
glvol="git@gitlab.com:r-gregor/vlpprs_${HST}.git"

echo "[i] Push to ${ghvol} ..."
${git_nvol} push ${ghvol} main
echo "---"

echo "[i] Push to ${glvol} ..."
${git_nvol} push ${glvol} main
echo "---"

