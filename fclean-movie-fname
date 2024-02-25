#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# version: V6
# date: 20180104
# date: 20180105: curdir, fileslist, action on all files that contain [YTS-AG] ...
# date: 20180312: nef function with regex to select everything after (YYYY) ...
# date: 20190916: curdir, fileslist, action on all files that contain [YTS-..] ...
# clean movie dirname

import os, sys
import datetime as dt
import re

# timestamp
def tms():
    return dt.datetime.now().strftime('%Y%m%d_%H%M%S')

# MESSAGE:
print("[ {} ] Starting {} ...".format(tms(), sys.argv[0]))

# fnames
fnames = os.listdir(".")

def clean_fname(orig_fname):
    # check if cont_pat in filename
    regx_FNM = re.compile(r'[-_.]\[YTS[-_.]..\]')
    regx_FOB = regx_FNM.search(orig_fname)
    if regx_FOB != None:
        regx_PAT = regx_FOB.group()
        PAT = regx_FOB.group()
        new_fname = orig_fname.replace(PAT, '')
        return new_fname

TL = []
for fn in fnames:
    n_fname = clean_fname(fn)
    if n_fname != None:
        if fn != n_fname:
            TL.append(fn)

if TL == []:
    print("[ {} ] No files with [YTS*A*] in fname found!".format(tms()))
    print("[ {} ] Done.".format(tms()))
    sys.exit(1)

print("[ {} ] {} files with [YTS*A*] in fname found!".format(tms(), len(TL)))
gr_yesno = input("[ {} ] Continue? __ ".format(tms()))

for fn in TL:
    n_fname = clean_fname(fn)
    print("[ {} ] Renaming {} --> {}".format(tms(), fn, n_fname))
    os.rename(fn, n_fname)
