#! /usr/bin/env bash
# fname: nvol-testpush-all.sh
# descpt: Testpush to majvolpejprs remote
# 20240823
# 20260925: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260925
# ---

export VOLGITDIR="${HOME}/majstaf/${HST}git/vlpprs_${HST}"
export VOLWORKDIR="${HOME}/majstaf/majvolpejpers"
vol_cmd="/usr/bin/git --git-dir=${VOLGITDIR} --work-tree=${VOLWORKDIR}"

ghvol="git@github.com:r-gregor/vlpprs_${HST}.git"
glvol="git@gitlab.com:r-gregor/vlpprs_${HST}.git"

echo "[i] Testpush to ${ghvol} ..."
${vol_cmd} push --dry-run ${ghvol} main
echo "---"

echo "[i] Testpush to ${glvol} ..."
${vol_cmd} push --dry-run ${glvol} main
echo "---"

