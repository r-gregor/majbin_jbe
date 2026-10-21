#! /bin/bash
### backup .../Dropbox/{ODPRTO,SKUPNI} from doma to $HOME/majstaf/bckps_all/drpbx_bckp
###

# timestamp
tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}

crtn=100
crtc() {
    for ((i=1; i<=$1; i++)); do
        echo -n "-"
    done
    echo
}

tms; echo "Starting $0 ..."

gr_DEJTT="$(date +%Y%m%d_%H%M)"
gr_DBX=$HOME/Dropbox
gr_DBO=${gr_DBX}/ODPRTO
gr_DBS=${gr_DBX}/SKUPNI
gr_DEST=$HOME/majstaf/bckps_all/bckp_drpbx
gr_LOG=$HOME/majstaf/bckps_all/bckp.log

tms; echo "Removing old files from ${gr_DEST} ... "
rm -v ${gr_DEST}/* | grep -v '^[[:space:]]*$' | while read line; do (tms; echo $line); done
tms; echo "[OK]"

tms; echo "Backing up ... /Dropbox/{SKUPNI,ODPRTO}/*"
tms; echo -n "to $HOME/majstaf/bckps_all/drpbx_bckp  "

tar -c --checkpoint=200 --checkpoint-action=dot -zf ${gr_DEST}/rut@home@rgregor@bckps_all@drpbx_bckp@Dropbox@SKUPNI_${gr_DEJTT}.tar.gz -C ${gr_DBX} SKUPNI
echo
tar -c --checkpoint=200 --checkpoint-action=dot -zf ${gr_DEST}/rut@home@rgregor@bckps_all@drpbx_bckp@Dropbox@ODPRTO_${gr_DEJTT}.tar.gz -C ${gr_DBX} ODPRTO

echo
(tms; echo "Successfully backed up .../Dropbox/{ODPRTO,SKUPNO} to ${gr_DEST}/") | tee -a ${gr_LOG} # append to log
tms; echo "DONE!"
crtc $crtn
