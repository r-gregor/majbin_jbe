#! /usr/bin/env bash
# fname: repair1-quotation-marks.sh
# descpt: replace quotation and graphical characters for conversion into pdf-format
# 20261021
# last: 20261021
# ---


# converting STRANGE quotation marks to NORMAL ones:
# ‘ (left single quotation mark \u2018)                     --> to '
# ’ (right single quotation mark \u2018)                    --> to '
# “ (left double quotation mark \u201c)                     --> to "
# ” (right double quotation mark \u201d)                    --> to "
# ` (GRAVE ACCENT \u0060)                                   --> to $(
# ´ (ACUTE ACCENT \u00B4)                                   --> to )
#           `my_cmd param´ --> $(my_comd param)
#  « (LEFT-POINTING DOUBLE ANGLE QUOTATION MARK \u00AB)     --> to "
#  » (RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK \u00BB)    --> to "
#  — (Em dash \u2014)                                       --> to -
#  – (En dash \u2013)                                       --> to -
#  … (ellipsis \u2026)                                      --> to ...
#  ├ (Box drawing light vert light right \u251C)            --> to +
#  ─ (Box Drawings Light Horizontal \u2500)                 --> to -
#  │ (Box Drawings Light Vertical \u2502)                   --> to |
#
#  └ (Box Drawings Light Up and Right \u2514)               --> to +
#
#  version V2: 20190325: added left/right pointing double qmarks, Em dash and elipsis
#  version V3: 20190710: added box chars
#

# === MAIN ===
if [ $# -ne 1 ]; then
	printf "[e] must suply single filename\n\n"
	exit 1
else
	FJL="$1"
fi

sed -e "s/[$(printf "\u201c")$(printf "\u201d")]/\"/g" \
    -e "s/[$(printf "\u00ab")$(printf "\u00bb")]/\"/g" \
    -e "s/[$(printf "\u2018")$(printf "\u2019")]/'/g" \
    -e "s/$(printf "\u0060")/\$\(/g" \
    -e "s/$(printf "\u00B4")/\)/g" \
    -e "s/$(printf "\u2026")/.../g" \
    -e "s/$(printf "\u251C")/\+/g" \
    -e "s/$(printf "\u2514")/\+/g" \
    -e "s/$(printf "\u2500")/-/g" \
    -e "s/$(printf "\u2502")/\|/g" \
    -e "s/$(printf "\u2013")/-/g" \
    -e "s/$(printf "\u2014")/-/g" $FJL

printf "[i] done\n\n"

