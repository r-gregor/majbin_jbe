#! /usr/bin/env bash
# timestamp
function tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}

# START
tms; echo "Starting $0 ..."

# new IFS --> newline
gr_oldifs=$IFS
IFS=$'\n'

# reset counter 
gr_CNT=0

for gr_FJL in $(ls -1); do
    gr_NV=$(echo ${gr_FJL} | sed -e 's/[^A-Za-z0-9._-]/_/g' -e 's/\./-/g' -e 's/__/_/g' -e 's/--/-/g' -e 's/\(.*\)-/\1\./')
    
    # if nothing to change ...
    if [ ${gr_FJL} == ${gr_NV} ]; then
        :   # do NOTHING!
    else
        # increase counter
        let gr_CNT=${gr_CNT}+1
        
        # first move ...
        echo "Change: $gr_FJL"
        mv ${gr_FJL} ${gr_NV} 2> /dev/null

        # second move ...
        gr_NV2=$(echo ${gr_NV} | sed -e 's/_-_/-/g' -e 's/-_/-/g' -e 's/__/_/g' -e 's/--/-/g')
        echo "To:     ${gr_NV2}"
        mv ${gr_NV} ${gr_NV2} 2> /dev/null
        echo
    fi
done

# if nothing to change ...
if [ ${gr_CNT} -eq 0 ]; then
    tms; echo "Nothing to replace ..."
fi

tms; echo "Done!"

# back to original IFS ...
IFS=${gr_OLDIFS}


