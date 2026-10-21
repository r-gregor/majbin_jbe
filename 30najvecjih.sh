#! /bin/bash
# filename: 30najvecjih.sh
# descpt: displays 30 largest files sorted by space usage
# 20260928
# last: 20260928
# ---


# Variables:
vDATE=$(date +%Y%m%d_%H%M)
vDEST1="${HOME}/majstaf/seznami"
vFILE1="30.najvecjih_${vDATE}.txt"
gFinalDest="${vDEST1}/${vFILE1}"

printf "[INFO] creating ${gFinalDest}...\n"
touch "${gFinalDest}"

vIZHD="/c"
vSZNM=~/.tmp/list.dat
vDIRSI=~/.tmp/list-by-size.dat
vST_ZNAKOV=85

grf_crtice () {
	printf "%${vST_ZNAKOV}s\n" | tr " " "-"	# draw a line of "-" number-of-chars times ...
}

grf_crtice
printf "%s\n" "[ $(date +%Y%m%d_%H%M) ] starting script \"$0\" ..."

grf_crtice

if [ -f "${vSZNM}" ]; then
	rm -vvv "${vSZNM}"
fi

	rm -vvv "${vDIRSI}"
fi

du -h --max-depth=1 "${vIZHD}" 2>/dev/null | sort -hr | head -n 30 >> "${vDIRSI}"

grf_crtice
cat -n "${vDIRSI}" | tee "${gFinalDest}"

cat "${vDIRSI}" | awk '{$1=""; print $0}' >> "${vSZNM}"


while read F; do 	
	echo "---------------------------------------------------------------" >>  "${gFinalDest}"
	du -ah --max-depth=2 "${F}/" 2> /dev/null | sort -hr | head -n5 >> "${gFinalDest}"

done <"${vSZNM}"
grf_crtice

