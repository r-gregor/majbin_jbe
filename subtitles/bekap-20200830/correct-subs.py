#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# update 20190406

import time     # only needed for backwards countown - test
import os
import sys

import datetime as dt
import m_correct_time

tmstmp = dt.datetime.now().strftime('%Y%m%d_%H%M%S')


# timestamp
def tms():
    return dt.datetime.now().strftime('%Y%m%d_%H%M%S')

# MESSAGE:
print("[ {} ] Starting {} ...".format(tms(), sys.argv[0]))


msg = '''
Usage: {0} [ filename.srt] [time delay +- N in seconds]
  copy {0} to directory with filename.srt and run upper command!
'''.format(sys.argv[0])


if len(sys.argv) < 3:
    print("[ {} ] Too few arguments".format(tms()))
    print(msg)
    exit(1)

cur_drv = os.path.abspath(".")
file_arg = sys.argv[1]
file_in = cur_drv + "/" + file_arg
td = sys.argv[2]


# Check if files exist:
if not os.path.isfile(file_in):
    print("[ {} ] There is no ".format(tms()) + file_in + ".")
    print(msg)
    sys.exit(1)

file_out = cur_drv + "/" + "subs_corrected_" + str(tmstmp) + ".srt"


# create a list of lines, strip trailing '\n' off
L1 = []
with open(file_in, 'r') as fin:
    for line in fin.readlines():
        if line != '\n':
            # if line not newline strip off trailing newline
            if '-->' not in line:
                L1.append(line.strip().split(','))
            else:
                L1.append(line.strip().split())

        else:
            L1.append(line.split())

# test
# print(L1)
# time.sleep(5)

# create output list: if not time string just copy it over from L1. If it is time string replace it with new
# time string from function ...
L2 = []


for el in L1:
    if '-->' not in el:
        # if not time string: copy contents from L1
        L2.append(' '.join(el))
    else:
        # output of the correct function ...
        ct = m_correct_time.correct_time(el, td)
        L2.append(' '.join(ct.split()))

'''
# PRINT OUT - CHECK
# for each elemnt in a list print sigle line
for el in L2:
    if el == '':
        # if element newline, print with aditional newline striped off
        print(el.strip())
    else:
        print(el)
'''

# ACTUAL WRITE TO OUTPUT FILE !!! ----------------------------------------------------------------------------
print("[ {} ] Exporting corrected srt-file to: {} ...".format(tms(), file_out))
with open(file_out, 'w') as fout:
    # for each elemnt in a list print sigle line
    for el in L2:
        if el == '\n':
            # if element newline, print with aditional newline striped off
            fout.write((el.strip()))
            fout.write('\n') # NEEDED OR ELSE: SINGLE STRING
        else:
            fout.write(el)
            fout.write('\n') # NEEDED OR ELSE: SINGLE STRING
print("[ {} ] Done!".format(tms()))
