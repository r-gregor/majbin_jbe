#! /bin/bash

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
#  … (elipsys)                                              --> to ...
#
#  version V2: 20190325: added left/right pointing double qmarks, Em dash and elipsis
#

FJL=$1

# command
sed -e "s/[$(printf "\u201c")$(printf "\u201d")]/\"/g" \
    -e "s/[$(printf "\u00ab")$(printf "\u00bb")]/\"/g" \
    -e "s/[$(printf "\u2018")$(printf "\u2019")]/'/g" \
    -e "s/$(printf "\u0060")/\$\(/g" \
    -e "s/$(printf "\u00B4")/\)/g" \
    -e "s/$(printf "\u2026")/.../g" \
    -e "s/$(printf "\u2014")/-/g" $FJL
    
