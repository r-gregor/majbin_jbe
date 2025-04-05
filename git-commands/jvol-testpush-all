#! /usr/bin/env bash
# filename: jvol-testpush-all
# last update: 20250406

HST="jbe"

export VOLGITDIR="${HOME}/majstaf/${HST}git/vlpprs_${HST}"
export VOLWORKDIR="${HOME}/majstaf/majvolpejpers"

vol_cmd="/usr/bin/git --git-dir=${VOLGITDIR} --work-tree=${VOLWORKDIR}"

echo "[INFO] Testpush to d_GITHUB ..."
${vol_cmd} push --dry-run git@github.com:r-gregor/vlpprs_${HST}.git main
echo "---"

echo "[INFO] Testpush to d_GITLAB ..."
${vol_cmd} push --dry-run git@gitlab.com:r-gregor/vlpprs_${HST}.git main
echo "---"

