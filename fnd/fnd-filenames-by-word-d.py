#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# argpase test 20071026
import argparse
import os, sys

BL = []
curdir = os.getcwd()

# REAL destination:
BL = os.listdir(curdir)

# test destination:
# BL = os.listdir('/home/rgregor/Dropbox/ODPRTO/_PYTHON')

# arguments parser:
# options -o --or: any of the arguments (part of the filename) must match,
# options -a --and: all of the arguments (part of the filename) must match,
# options -s --single: only ONE (single) arguments (part of the filename) must match.

# check if argument given:
if len(sys.argv) < 2:
    print("No argument given!\nRun: {} -h or --help.".format(sys.argv[0]))
    sys.exit(1)


parser = argparse.ArgumentParser()
parser.add_argument("-o", "--or", dest = 'orlist', default = [], nargs = '+', help = 'Use option -o to use OR for combination of WORDs')
parser.add_argument("-a", "--and", dest = 'andlist', default = [],  nargs = '+', help = 'Use option -a to use AND for combination of WORDs')
parser.add_argument("-s", "--single", dest = 'single',  default ="", nargs = 1, help = 'Use option -s to use a single WORD')
args = parser.parse_args()


if len(sys.argv) < 2:
    print("Arguments required!\nRun: {} -h for help.".format(sys.argv[0]))
    sys.exit(1)

gr_orlist = args.orlist
gr_andlist = args.andlist
gr_single = ''.join(args.single) # convert list to a string


if gr_orlist != []:
    print('Selected arguments:', gr_orlist)
    for F in BL:
        # True if ANY of the items in gr_orlist match items in F (single filename from BL)
        if any(item in F for item in gr_orlist):
            print(F)
#        else:
#            break
#            print("No argument from", gr_orlist, "matches any part of filenames in", os.getcwd())

elif gr_andlist != []:
    print('Selected arguments:', gr_andlist)
    for F in BL:
        # True if ALL items in gr_andlist match items in F (single filename from BL)
        if all(item in F for item in gr_andlist):
            print(F)
#        else:
#            break
#            print("Arguments from", gr_andlist, "do not match any part of filenames in", os.getcwd())
elif gr_single != '':
    print('Selected argument:', gr_single)
    for F in BL:
        if gr_single in F:
            print(F)
#        else:
#            break
#            print(gr_sible, "does not match any part of filenames in", os.getcwd())
