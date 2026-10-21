#! /bin/bash
### backup .../Dropbox/{ODPRTO,SKUPNI} from doma to $HOME/majstaf/bckps_all/drpbx_bckp
###

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


# MAIN

tms; echo "Started: $0"
tms; crtc ${crtn}
gDejtt="$(date +%Y%m%d_%H%M)"
gDbx=$HOME/Dropbox
gDbo=${gDbx}/ODPRTO
gDbs=${gDbx}/SKUPNI
gDest=$HOME/majstaf/bckps_all/bckp_drpbx
gLog=$HOME/majstaf/bckps_all/bckp.log

tms; echo "Removing old files from ${gDest} ... "
rm -v ${gDest}/* | grep -v '^[[:space:]]*$' | while read line; do (tms; echo $line); done
tms; echo "---"

### 20240513
### tms; echo "Backing up ... /Dropbox/ODPRTO/* to $HOME/majstaf/bckps_all/drpbx_bckp ..."
### tar -c --checkpoint=200 --checkpoint-action=dot -zf ${gDest}/rut@home@rgregor@bckps_all@drpbx_bckp@dropbox@odprto_${gDejtt}.tar.gz -C ${gDbx} ODPRTO
### echo
tms; echo "Backing up ... /Dropbox/SKUPNI/* to $HOME/majstaf/bckps_all/drpbx_bckp ..."
tar -c --checkpoint=200 --checkpoint-action=dot -zf ${gDest}/rut@home@rgregor@bckps_all@drpbx_bckp@dropbox@skupni_${gDejtt}.tar.gz -C ${gDbx} SKUPNI

echo
### (tms; echo "Successfully backed up .../Dropbox/{ODPRTO,SKUPNI} to ${gDest}/") | tee -a ${gLog} # append to log
(tms; echo "Successfully backed up .../Dropbox/SKUPNI to ${gDest}/") | tee -a ${gLog} # append to log
tms; echo "DONE!"
crtc ${crtn}
