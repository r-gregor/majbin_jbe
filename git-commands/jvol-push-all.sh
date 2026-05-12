#! /usr/bin/env bash
# filename: jvol-push-all
# last update: 20250406

HST="jbe"

export VOLGITDIR="${HOME}/majstaf/${HST}git/vlpprs_${HST}"
export VOLWORKDIR="${HOME}/majstaf/majvolpejpers"

mdbg_vol="/usr/bin/git --git-dir=${VOLGITDIR} --work-tree=${VOLWORKDIR}"

echo "[INFO] Push to d_GITHUB ..."
${mdbg_vol} push git@github.com:r-gregor/vlpprs_${HST}.git main
echo "---"

echo "[INFO] Push to d_GITLAB ..."
${mdbg_vol} push git@gitlab.com:r-gregor/vlpprs_${HST}.git main
echo "---"

