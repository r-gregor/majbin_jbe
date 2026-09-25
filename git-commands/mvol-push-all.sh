#! /usr/bin/env bash
# filename: mvol-push-all
# descpt: PUSH majvolpejprs to remote
# 20260924: unified scripts for linux
#           HST and system info from exported global variable
# last: 20260924
# ---

export VOLGITDIR="${HOME}/majstaf/${HST}git/vlpprs_${HST}"
export VOLWORKDIR="${HOME}/majstaf/majvolpejpers"

# vol_cmd="/usr/bin/git --git-dir=${VOLGITDIR} --work-tree=${VOLWORKDIR}"
vol_cmd() {
	/usr/bin/git --git-dir="${VOLGITDIR}" --work-tree="${VOLWORKDIR}" "$@"
}

echo "[INFO] Push to d_GITHUB ..."
vol_cmd push git@github.com:r-gregor/vlpprs_${HST}.git main
echo "---"

echo "[INFO] Push to d_GITLAB ..."
vol_cmd push git@gitlab.com:r-gregor/vlpprs_${HST}.git main
echo "---"

