#! /usr/bin/env python3

import re
import sys
import os
from os import listdir
from os.path import isdir, join

if len(sys.argv) == 2:
	dirpath = os.path.abspath(sys.argv[1])
else:
	dirpath = "."

os.chdir(dirpath)

onlydirs = [d for d in listdir(dirpath) if isdir(d)]
# test;
# print(onlydirs)

flist = []

def get_expr(fname):
	# M = re.search("([0-9]{4})", fname)
	M = re.search("\(([0-9]{4})\)", fname)
	if M:
		expr = (M.group(1), fname)
		flist.append(expr)
	else:
		pass

for fname in onlydirs:
	get_expr(fname)

flist.sort(reverse=True)

for fname2 in flist:
	print(f"{fname2[0]:<6}{fname2[1]}")

