#!/bin/bash

### ------------------------------------------------------------------------
### name:       bckpd.V4.sh
### author:     RgregoR
### date:       september 2013 / updated 20150326 / 20150414 / 20150526
###             updated 20180527 (added $HOME/RUT)
### ------------------------------------------------------------------------
### Description:
### script that creates gzipped tar backup of $HOME/* files
### and $HOME/majstaf/forallusers/*
### 1 - checks if at destination folder  is an existing arcive and delets it
### 2 - creates the archive in the destination folder
###
### ------------------------------------------------------------------------

# *************************************************************
# VARIABLES
# =========

# timestamp
tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}

crtn=3
crtc() {
    for ((i=1; i<=$1; i++)); do
        echo -n "-"
    done
    echo
}



# source folder:
gr_FROMCDNG=$HOME/majstaf

gFromBrc="$HOME/.[hidden files]"
gFromSzn=$HOME/majstaf/seznami
# gFromMtss=$HOME/majstaf/metsys
gFromMtss=$HOME/majstaf/metsys

# destination folder
# !!! PAZI-  POT ZA ARHIVO !!!
gDest=$HOME/majstaf/bckps_all/bckp_muadib
gLog=$HOME/majstaf/bckps_all/bckp.log


# datestamp:
gDate=$(date +%Y%m%d_%H%M%S)

# archive:
gCurrCdng="bckp_cdng_d_${gDate}.tar.gz"
gCurrFau="bckp_rcs_d_${gDate}.tar.gz"
gCurrSzn="bckp_szn_d_${gDate}.tar.gz"
gCurrBrc="bckp_brc_d_${gDate}.tar"
gCurrDoma="bckp-doma_d_${gDate}.tar.gz"
gCurrMtss="bckp_mtss_d_${gDate}.tar.gz"



# MAIN

tms; echo "Started: $0"
tms; crtc ${crtn}

# TEST if archive file exists:
if [ "$(ls -A ${gDest})" ]; then
	tms; echo "${gDest}/ is NOT empty!"
	# Ask for confirmation:
	# read -r -p "[?] Press any key to REMOVE files or [ctrl+c] to quit"
	tms; echo "Removing files from ${gDest}/ ... "
	rm -v ${gDest}/* | grep -v '^[[:space:]]*$' | while read line; do (tms; echo $line); done
	tms; crtc ${crtn}
else
	tms; echo "${gDest}/ is empty ..."
fi

# creating an archive:
tms; echo -n "Creating archive: ${gDest}/${gCurrCdng} ... "
tar -czf ${gDest}/${gCurrCdng} -C ${HOME}/majstaf coding2 majbin
echo "[OK]"

tms; echo -n "Creating archive: ${gDest}/${gCurrFau} ... "
tar -czf ${gDest}/${gCurrFau} -C ${HOME}/majstaf majrcs
echo "[OK]"

tms; echo -n "Creating archive: ${gDest}/${gCurrSzn} ... "
tar -czf ${gDest}/${gCurrSzn} -C ${HOME}/majstaf seznami
echo "[OK]"

tms; echo -n "Creating archive: ${gDest}/${gCurrMtss} ... "
tar -czf ${gDest}/${gCurrMtss} -C ${HOME}/majstaf metsys
echo "[OK]"

tms; echo -n "Creating archive: ${gDest}/${gCurrBrc} ... "
cd $HOME && find -maxdepth 1 -type f -iname "\.*" | tar -cf ${gDest}/${gCurrBrc} -T -
cd $HOME && tar -rf ${gDest}/${gCurrBrc} -C ${HOME}/majstaf ".alseg/"
gzip ${gDest}/${gCurrBrc}
echo "[OK]"

(tms; echo "successfully backed up CODING, RCS, SZN, MTSS and BRC archives to ${gDest}/") | tee -a ${gLog} # append to log
tms; echo "DONE!"
tms; crtc ${crtn}

